require 'test/unit'

class TestRequireAndLoad < Test::Unit::TestCase
  def test_require_only_once
    require 'fixtures/require_me'
    require 'fixtures/require_me'
    assert_equal 1, $require_count
    assert $LOAD_PATH.include?('test')
  end

  def test_load_runs_each_time
    load 'fixtures/load_me.rb'
    load 'fixtures/load_me.rb'
    assert_equal 2, $load_count
  end

  def test_fail_to_require
    begin
      require 'foo'
      fail 'expect LoadError'
    rescue LoadError
    end
  end

  def test_modify_load_path
    $LOAD_PATH << 'test/fixtures'
    require 'foo'
    assert $LOADED_FEATURES.include?('foo.rb')
  end
end