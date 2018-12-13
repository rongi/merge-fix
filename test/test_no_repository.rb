require 'test/unit'

class TC_NoRepository < Test::Unit::TestCase

  def setup
    `mkdir #{Dir.home}/mergefix-test-empty`
  end

  def teardown
    `rm -rf #{Dir.home}/mergefix-test-empty`
  end

  def test__no_repository__exit
    current_dir = Dir.pwd

    Dir.chdir("#{Dir.home}/mergefix-test-empty") {
      `#{current_dir}/../mergefix`
      exit_status = $? >> 8
      assert_not_equal(0, exit_status)
    }
  end

end
