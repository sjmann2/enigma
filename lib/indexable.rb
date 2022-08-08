module Indexable
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

    shifts = @shift_calculator.shift_calculator(key, date)

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
    shifts = @shift_calculator.shift_calculator(key, date)

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
end