require_relative './enigma'

enigma = Enigma.new

message_file = File.open(ARGV[0], "r")

message = message_file.read

message_file.close

encrypted_text_hash = enigma.encrypt(message, key = enigma.key_generator, date = enigma.date_generator)

encrypt = File.open(ARGV[1], "w")

encrypt.write(encrypted_text_hash[:encryption])
puts "created 'encrypted.txt' with the key #{key} and date #{date}"

encrypt.close