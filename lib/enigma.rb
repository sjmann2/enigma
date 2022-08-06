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

    character_index_value = []
    message.each_char.with_index do |char, index|
      @characters.with_index do |character, index_2|
        if character == char
          character_index_value << index_2
        end
      end
    end
    encrypted_index_value = []
    character_index_value.with_index do |value, index|
      if index % 4 == 0
        encrypted_index_value << value + a_shift
      elsif index % 4 == 1
      elsif index % 4 == 2
      elsif index % 4 == 3
      end
    end

    encrypted_message = []
    encrypted_index_value.map do |position|
      encrypted_message << @characters[position]
    end.join(" ")
  end
end