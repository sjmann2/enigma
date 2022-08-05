require "date"

class Enigma
  attr_reader :characters

  def initialize
    @characters = ("a".."z").to_a << " "
  end

  def date_generator
    Date.today.strftime("%d%m%y")
  end

  def key_generator
    5.times.map { rand(10) }.join
  end

  def offset_generator(date)
    squared_date = (date.to_i ** 2).to_s
    squared_date[-4..-1]
  end

  def encrypt(message, key = key_generator, date = date_generator)
    # :encryption => the encrypted String
    # :key => the key used for encryption as a String
    # :date => the date used for encryption as a String in the form DDMMYY
    # encryption = {
    #   encryption:
    #   key:
    #   date:
    # }
    offset = offset_generator(date)

    a_shift = (key[0] + key[1]).to_i + offset[0].to_i #3
    b_shift = (key[1] + key[2]).to_i + offset[1].to_i #27
    c_shift = (key[2] + key[3]).to_i + offset[2].to_i #73
    d_shift = (key[3] + key[4]).to_i + offset[3].to_i #20

    message[0].each_char.with_index do |char, index|
      #for A: start at 1 and go every 4th
      #for B: start at 2 and go every 4th
      #for C: start at 3 and go every 4th
      #for D: start at 4 and go every 4th
      a_shift char

      message[0..-1].each_char.with_index do |char, index|
        if index % 4 == 0
          puts char
        end
      end
      #start at index 0, iterate through the end, give me the
      #character at index position that are divisible by 4
      message[1..-1].each_char.with_index do |char, index|
        if index % 4 == 0
          puts char
        end
      end
      message[2..-1].each_char.with_index do |char, index|
        if index % 4 == 0
          puts char
        end
      end
      message[3..-1].each_char.with_index do |char, index|
        if index % 4 == 0
          puts char
        end
      end
    end
  end
end
