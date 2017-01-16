class HelloWorld
  attr_reader :name

  def self.hello(name=nil)
    if name
      "Hello, #{name}!"
    else
      "Hello, World!"
    end
  end

end
