require 'date'

class Enigma
  attr_reader :characters

  def initialize
    @characters = ("a".."z").to_a << " "
  end

  def date_generator
    Date.today.strftime("%d%m%y")
  end

  def key_generator
    5.times.map{rand(10)}.join
  end

  def offset_generator(date_generator)
    squared_date = (date_generator.to_i ** 2).to_s
    squared_date[-4..-1]
  end
end