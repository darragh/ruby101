require 'test/unit'

class Symbol
  def to_proc
    Proc.new {|x, *args| x.send(self, *args)}
  end
end

class Person
  def <=>(other)
    self.name <=> other.name
  end
  
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def method_missing(name, *args)
    name = name.to_s
    if name.end_with?('?') and self.respond_to?(name.delete('?'))
      self.send(name.delete('?'))
    end
  end
end
class TestArray < Test::Unit::TestCase
  def test_out_of_bounds_is_nil
    assert_equal nil, [][6]
  end

  def test_index_from_end
    assert_equal 4, [1,2,3,4,5][-2]
  end

  def test_compact
    assert_equal [1,2,3], [1,2,nil,3,nil].compact
  end

  def test_each
    sum = 0;
    [1,2,3].each{|x| sum = sum + x}
    assert_equal 6, sum
  end

  def test_inject
    assert_equal 6, [1,2,3].inject(0){|sum, x| sum + x}
  end

  def test_map
    assert_equal [1,4,9], [1,2,3].map{|x| x * x }
    square = Proc.new {|x| x * x}
    assert_equal [1,4,9], [1,2,3].map(&square)
    assert_equal [3,5,6], ['boo','hello','amazon'].map{|word| word.length}
    assert_equal [3,5,6], ['boo','hello','amazon'].map(&:length)
  end

  def test_uniq
    assert_equal [1,2,3], [1,2,2,3,3,3,3,1].uniq
    assert_equal [1,2,3], [3,1,2,2,3,3,3,3,1].uniq.sort
    a = [1,2,2,3,3,3,3,1]
    assert_equal [1,2,3], a.uniq
    assert_equal 8, a.length
    assert_equal [1,2,3], a.uniq!
    assert_equal 3, a.length
  end

  def test_flatten
    assert_equal [1,2,3,4], [[1,2],[3,4]].flatten
  end

  def test_sort
    assert_equal [1,2,3], [3,1,2].sort
    darragh = Person.new('darragh')
    richard = Person.new('richard')
    assert_equal [darragh,richard], [richard, darragh].sort
  end

  def test_all_any_none_one_etc
    assert [1,2,3].all?{|x| x > 0}
    assert [1,2,3].any?{|x| x >= 3}
    assert [1,2,3].none?{|x| x > 3}
    assert [1,2,3].one?{|x| x == 3}
  end

  def test_name?
    richard = Person.new('richard')
    assert_equal 'richard', richard.name?
  end

end