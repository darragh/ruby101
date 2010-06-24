class DDD
  def my_method
    @x
  end

  def self.incr
    @x = @x + 2
  end

  def self.x
    @@x
  end

  def x=(y)
    @@x = y
  end

  def x
    @@x
  end
end

d = DDD.new
d.x = 5

puts d.x
puts DDD.x