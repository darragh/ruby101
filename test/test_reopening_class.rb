require 'test/unit'

class Array
  %w(first second third fourth fifth sixth).each_with_index do |name, index|
    define_method name do
      self[index]
    end
  end
end

class TestReopeningClass < Test::Unit::TestCase
  def test_index_by_name
    assert_equal 5, [1,3,5,7].third
    assert_equal nil, [1,3,5,7].fifth
  end
end