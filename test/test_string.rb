require 'test/unit'

class NilClass
  def blank?
    true
  end
end

class String
  def blank?
    self.empty? || self =~ /\s/
  end
end
class TestString < Test::Unit::TestCase
  def test_start_with_end_with
    assert 'hello'.start_with?('he')
    assert 'hello'.end_with?('lo')
  end

  def test_each_line
    results = []
    "a\nb".each{|line| results << line.strip}
    assert_equal ['a','b'], results
  end

  def test_delete
    assert_equal 'abc', "a,b-c".delete(',-')
  end

  def test_substing
    input = "123456789"
    assert_equal '2345', input[1...5]
  end

  def test_split
    assert_equal ['a=b', 'c=d'], "a=b&c=d".split('&')
  end

  def test_empty
    assert "".empty?
    assert " ".blank?
    assert " \n".blank?
    assert nil.blank?
  end
end