module Indexable
  def find_character_index_values(message)
    message.downcase!
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

  def encrypted_message(message, key, date)
    character_index_values = find_character_index_values(message)

    shifts = @shift_calculator.shift_calculator(key, date)

    encrypted_message = []

    character_index_values.each_with_index do |value, index|
      if value.class == Array
        encrypted_message << value
      elsif index % 4 == 0
        encrypted_message << @characters[(value + shifts[:a_shift]) % 27]
      elsif index % 4 == 1
        encrypted_message << @characters[(value + shifts[:b_shift]) % 27]
      elsif index % 4 == 2
        encrypted_message << @characters[(value + shifts[:c_shift]) % 27]
      elsif index % 4 == 3
        encrypted_message << @characters[(value + shifts[:d_shift]) % 27]
      end
    end
    encrypted_message.join
  end

  def decrypted_message(message, key, date)
    character_index_values = find_character_index_values(message)
    shifts = @shift_calculator.shift_calculator(key, date)

    decrypted_message = []
    character_index_values.each_with_index do |value, index|
      if value.class == Array
        decrypted_message << value
      elsif index % 4 == 0
        decrypted_message << @characters[(value - shifts[:a_shift]) % 27]
      elsif index % 4 == 1
        decrypted_message << @characters[(value - shifts[:b_shift]) % 27]
      elsif index % 4 == 2
        decrypted_message << @characters[(value - shifts[:c_shift]) % 27]
      elsif index % 4 == 3
        decrypted_message << @characters[(value - shifts[:d_shift]) % 27]
      end
    end
    decrypted_message.join
  end
end