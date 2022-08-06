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

  def offset_calculator(date)
    squared_date = (date.to_i ** 2).to_s
    squared_date[-4..-1]
  end

  def shift_calculator(key = key_generator, date = date_generator)
    offset = offset_calculator(date)
  
    shifts = { 
      a_shift: (key[0] + key[1]).to_i + offset[0].to_i,
      b_shift: (key[1] + key[2]).to_i + offset[1].to_i,
      c_shift: (key[2] + key[3]).to_i + offset[2].to_i,
      d_shift: (key[3] + key[4]).to_i + offset[3].to_i
    }
  end

  def encrypt(message, key = key_generator, date = date_generator)
    message.downcase!
    shifts = shift_calculator(key, date)

    character_index_value = []
    #[7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
    message.each_char.with_index do |char, index|
      @characters.each_with_index do |character, character_index|
        if character == char
          character_index_value << character_index
        end
      end
    end

    encrypted_index_value = []
    #[10, 31, 84, 31, 17, 53, 95, 34, 20, 38, 76]
    character_index_value.each_with_index do |value, index|
      if index % 4 == 0
        encrypted_index_value << (value + shifts[:a_shift]) % 27
      elsif index % 4 == 1
        encrypted_index_value << (value + shifts[:b_shift]) % 27
      elsif index % 4 == 2
        encrypted_index_value << (value + shifts[:c_shift]) % 27
      elsif index % 4 == 3
        encrypted_index_value << (value + shifts[:d_shift]) % 27
      end
    end
    encrypted_message = []
    encrypted_index_value.each do |position|
      encrypted_message << @characters[position]
    end

    encryption = {
      :encryption => encrypted_message.join,
      :key => key,
      :date => date,
    }
  end

  def decrypt(ciphertext, key, date = date_generator)
    shifts = shift_calculator(key, date)

    character_index_value = []
    #[10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]
    ciphertext.each_char.with_index do |char, index|
      @characters.each_with_index do |character, character_index|
        if character == char
          character_index_value << character_index
        end
      end
    end
    decrypted_index_value = []
    #[7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
    character_index_value.each_with_index do |value, index|
      if index % 4 == 0
        decrypted_index_value << (value - shifts[:a_shift]) % 27
      elsif index % 4 == 1
        decrypted_index_value << (value - shifts[:b_shift]) % 27
      elsif index % 4 == 2
        decrypted_index_value << (value - shifts[:c_shift]) % 27
      elsif index % 4 == 3
        decrypted_index_value << (value - shifts[:d_shift]) % 27
      end
    end
    decrypted_message = []
    decrypted_index_value.each do |position|
      decrypted_message << @characters[position]
    end
    decryption = {
      :decryption => decrypted_message.join,
      :key => key,
      :date => date
    }
  end
end
