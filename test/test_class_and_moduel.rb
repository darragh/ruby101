require 'test/unit'

module ExtraMethods
  def amazing?
    true
  end
end

class Extended
  extend ExtraMethods
end
class Goo
  def special(*periods)

  end
end
class Foo < Goo
  include ExtraMethods
  def bar
    true
  end

  def self.baz
    false
  end

  private
  def secretz
    'password'
  end
end

class Circle
  attr_reader :radius
  def initialize(radius)
    @radius = radius
  end
end

class TestClassAndModule < Test::Unit::TestCase
  def test_everything_is_an_object
    assert 1.is_a?(Object)
    assert true.is_a?(Object)
    assert 1.8.is_a?(Object)
    assert "1.8".is_a?(Object)
    assert [].is_a?(Object)
    assert nil.is_a?(Object)
    assert Object.is_a?(Object)
    assert String.is_a?(Object)
    assert "String".class.is_a?(Object)
  end

  def test_instance_vs_class_methods
    assert !Foo.baz
    assert Foo.new.bar
    assert Foo.respond_to?(:baz)
    assert !Foo.new.respond_to?(:baz)
  end

  def test_cant_call_private_method
    foo = Foo.new
    begin
      foo.secretz
      fail 'expected NoMethodErro'
    rescue NoMethodError
    end
    assert foo.private_methods.include?('secretz')
    assert !foo.methods.include?('secretz')
    assert_equal 'password', foo.send(:secretz)
  end

  def test_singleton_methods
    foo = Foo.new
    def foo.bar
      false
    end
    other = Foo.new
    assert !foo.bar
    assert other.bar
  end

  def test_constructor
    circle = Circle.new(10)
    assert_equal 10, circle.radius
  end

  def test_include_adds_instance_methods
    assert Foo.instance_methods.include?('amazing?')
    assert Foo.included_modules.include?(ExtraMethods)
    assert Foo.superclass.eql?(Goo)
  end

  def test_extend_adds_class_methods
    assert Extended.methods.include?('amazing?')
  end

  def test_splat_params
    def len(*args)
      args.length
    end
    assert_equal 3, len(1,2,4)
  end

  def test_block_param
    def identity(&block)
      block.call
    end
    assert_equal 4, identity {4}
  end
end