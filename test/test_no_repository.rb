require 'test/unit'

class TC_NoRepository < Test::Unit::TestCase

  def test__on_develop_branch__exit
      `../merge-fix`
      exit_status = $? >> 8
      assert_equal(1, exit_status)
  end

end