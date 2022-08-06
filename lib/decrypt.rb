require_relative './enigma'

enigma = Enigma.new

encrypted = File.open(ARGV[0], "r")

message = encrypted.read

encrypted.close

decrypted_text = enigma.decrypt(message, key = (ARGV[2]), date = (ARGV[3]))

decrypt = File.open(ARGV[1], "w")

decrypt.write(decrypted_text)
puts "created 'decrypted.txt' with the key #{key} and date #{date}"

decrypt.close