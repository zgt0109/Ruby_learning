require 'pry'
class HelloWorld
  attr_accessor :name
  def initialize(myname='Ruby')
    @name=myname
  end

  def hello
    p "Hello, world.I am #{self.name}"
  end

  class << self
    def hi(name)
      p "#{name} say hello"
    end
  end
  Version = '1.0'
  p self
  p self::Version
end
bob = HelloWorld.new('Bob')
bob.hello
p bob.name
HelloWorld.hi("ZGT")
# binding.pry
p self
