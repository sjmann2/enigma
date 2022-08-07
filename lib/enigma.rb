require "date"
require_relative "generatable"

class Enigma
  include Generatable
  attr_reader :characters

  def initialize
    @characters = ("a".."z").to_a << " "
  end

  def offset_calculator(date)
    squared_date = (date.to_i ** 2).to_s
    squared_date[-4..-1]
  end

  def shift_calculator(key, date)
    offset = offset_calculator(date)

    shifts = {
      a_shift: (key[0] + key[1]).to_i + offset[0].to_i,
      b_shift: (key[1] + key[2]).to_i + offset[1].to_i,
      c_shift: (key[2] + key[3]).to_i + offset[2].to_i,
      d_shift: (key[3] + key[4]).to_i + offset[3].to_i,
    }
  end

  def find_character_index_values(message)
    character_index_values = []
    message.each_char.with_index do |char, index|
      if !@characters.include?(char)
        character_index_values << [char]
      end
      @characters.each_with_index do |character, character_index|
        if character == char
          character_index_values << character_index
        end
      end
    end
    character_index_values
  end

  def find_encrypted_index_values(message, key, date)
    character_index_values = find_character_index_values(message)

    shifts = shift_calculator(key, date)

    encrypted_index_values = []

    character_index_values.each_with_index do |value, index|
      if index % 4 == 0 && value.class == Integer
        encrypted_index_values << (value + shifts[:a_shift]) % 27
      elsif index % 4 == 1 && value.class == Integer
        encrypted_index_values << (value + shifts[:b_shift]) % 27
      elsif index % 4 == 2 && value.class == Integer
        encrypted_index_values << (value + shifts[:c_shift]) % 27
      elsif index % 4 == 3 && value.class == Integer
        encrypted_index_values << (value + shifts[:d_shift]) % 27
      else
        encrypted_index_values << value
      end
    end
    encrypted_index_values
  end

  def find_decrypted_index_values(message, key, date)
    character_index_values = find_character_index_values(message)
    shifts = shift_calculator(key, date)

    decrypted_index_values = []
    character_index_values.each_with_index do |value, index|
      if index % 4 == 0 && value.class == Integer
        decrypted_index_values << (value - shifts[:a_shift]) % 27
      elsif index % 4 == 1 && value.class == Integer
        decrypted_index_values << (value - shifts[:b_shift]) % 27
      elsif index % 4 == 2 && value.class == Integer
        decrypted_index_values << (value - shifts[:c_shift]) % 27
      elsif index % 4 == 3 && value.class == Integer
        decrypted_index_values << (value - shifts[:d_shift]) % 27
      else
        decrypted_index_values << value
      end
    end
    decrypted_index_values
  end

  def encrypt(message, key = key_generator, date = date_generator)
    message.downcase!
    # shifts = shift_calculator(key, date)
    encrypted_index_values = find_encrypted_index_values(message, key, date)

    encrypted_message = []
    #encrypted_index_values = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22, ["!"]]
      encrypted_index_values.each do |position|
        if position.class == Array
          encrypted_message << position
        else
          encrypted_message << @characters[position]
        end
      end

    encryption = {
      :encryption => encrypted_message.join,
      :key => key,
      :date => date,
    }
  end

  def decrypt(message, key, date = date_generator)
    # shifts = shift_calculator(key, date)
    decrypted_index_values = find_decrypted_index_values(message, key, date)

    decrypted_message = []
    decrypted_index_values.each do |position|
      if position.class == Array
        decrypted_message << position
      else
        decrypted_message << @characters[position]
      end
    end

    decryption = {
      :decryption => decrypted_message.join,
      :key => key,
      :date => date,
    }
  end
end
