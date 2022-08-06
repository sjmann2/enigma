require_relative './enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")

message = handle.read

handle.close

encrypted_text_hash = enigma.encrypt(message, key = enigma.key_generator, date = enigma.date_generator)

encrypt = File.open(ARGV[1], "w")

encrypt.write(encrypted_text_hash[:encryption])
puts "created 'encrypted.txt' with the key #{key} and date #{date}"

encrypt.close