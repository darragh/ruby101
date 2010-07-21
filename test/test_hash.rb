require 'test/unit'
class TestHash < Test::Unit::TestCase
  def test_not_included
    assert_equal nil, {}['key']
    assert_equal 0, Hash.new(0)['key']
    assert_equal 4, Hash.new{|hash, key| hash[key] = key * 2}[2]
  end
end