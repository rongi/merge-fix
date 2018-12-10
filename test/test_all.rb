require 'test/unit'

class TC_All < Test::Unit::TestCase

  def setup
    `rm -rf ../test-output`

    `git init ../test-output/git-repository`
    `git init --bare ../test-output/git-repository.git`
    Dir.chdir('../test-output/git-repository') {
      `git checkout -b master`
      `touch file1`
      `git add file1`
      `git commit -m "first commit"`
      `git remote add origin ../git-repository.git`
      `git push origin master`
      `git branch --set-upstream-to=origin/master master`
    }
  end

  def teardown
    `rm -rf ../test-output`
  end

  def test__on_master_branch__exit
    Dir.chdir('../test-output/git-repository') {
      puts `../../mergefix`

      exit_status = $? >> 8
      assert_equal(100, exit_status)
      assert_equal('first commit', `git log --pretty=format:"%s"`)
      assert_equal('refs/heads/master', `git symbolic-ref HEAD`.strip)
    }
  end

  def test__merges_alright
    Dir.chdir('../test-output/git-repository') {
      `git checkout -b fix1`
      `echo 'som fix' >> file1`
      `git add .`
      `git commit -m "fixed a little"`

      puts `../../mergefix`

      assert_equal(0, $?)
      assert_equal("fixed a little\nfirst commit", `git log --pretty=format:"%s"`)
      assert_equal('refs/heads/master', `git symbolic-ref HEAD`.strip)
    }
  end

  def test__master_has_changes__merges_alright
    Dir.chdir('../test-output/git-repository') {
      `git checkout -b fix1`
      `echo 'som fix' >> file2`
      `git add .`
      `git commit -m "fixed a little"`

      `git checkout master`
      `git checkout -b fix2`
      `echo 'som fix 2' >> file1`
      `git add .`
      `git commit -m "fixed a little 2"`
      `git checkout master`
      `git merge fix2 --ff-only`
      `git push`
      `git checkout fix1`

      puts `../../mergefix`

      assert_equal(0, $?)
      assert_equal("fixed a little\nfixed a little 2\nfirst commit", `git log --pretty=format:"%s"`)
      assert_equal('refs/heads/master', `git symbolic-ref HEAD`.strip)
    }
  end

  def test__no_ff__merges_alright
    Dir.chdir('../test-output/git-repository') {
      `git checkout -b fix1`
      `echo 'som fix' >> file1`
      `git add .`
      `git commit -m "fixed a little"`

      puts `../../mergefix --no-ff`

      assert_equal(0, $?)
      assert_equal("Merge branch 'fix1'\nfixed a little\nfirst commit", `git log --pretty=format:"%s" --topo-order`)
      assert_equal('refs/heads/master', `git symbolic-ref HEAD`.strip)
    }
  end

end