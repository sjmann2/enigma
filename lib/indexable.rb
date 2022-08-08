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

  def find_encrypted_index_values(message, key, date)
    character_index_values = find_character_index_values(message)

    shifts = @shift_calculator.shift_calculator(key, date)

    encrypted_message = []

    character_index_values.each_with_index do |value, index|
      if value.class != Integer
        encrypted_message << value
      end
      if index % 4 == 0
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

  # def encrypted_index_to_letters(message, key, date)
  #   encrypted_index_values = find_encrypted_index_values(message, key, date)

  #   encrypted_message = []
  #   encrypted_index_values.each do |position|
  #     if position.class == Array
  #       encrypted_message << position
  #     else
  #       encrypted_message << @characters[position]
  #     end
  #   end
  #   encrypted_message
  # end

  def find_decrypted_index_values(message, key, date)
    character_index_values = find_character_index_values(message)
    shifts = @shift_calculator.shift_calculator(key, date)

    decypted_message = []
    character_index_values.each_with_index do |value, index|
      if value.class != Integer
        decypted_message << value
      end
      if index % 4 == 0
        decypted_message << @characters[(value - shifts[:a_shift]) % 27]
      elsif index % 4 == 1
        decypted_message << @characters[(value - shifts[:b_shift]) % 27]
      elsif index % 4 == 2
        decypted_message << @characters[(value - shifts[:c_shift]) % 27]
      elsif index % 4 == 3
        decypted_message << @characters[(value - shifts[:d_shift]) % 27]
      end
    end
    decypted_message.join
  end
end

#   def decrypted_index_to_letters(message, key, date)
#     decrypted_index_values = find_decrypted_index_values(message, key, date)

#     decrypted_message = []
#     decrypted_index_values.each do |position|
#       if position.class == Array
#         decrypted_message << position
#       else
#         decrypted_message << @characters[position]
#       end
#     end
#     decrypted_message
#   end
# end
