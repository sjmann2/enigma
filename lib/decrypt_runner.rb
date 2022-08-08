class DecryptRunner
  attr_reader :read_file_path,
              :write_file_path,
              :key,
              :date

  def initialize(read_file_path, write_file_path, key, date)
    @read_file_path = read_file_path
    @write_file_path = write_file_path
    @key = key
    @date = date
    @enigma = Enigma.new
  end

  def run
    encrypted = File.open(@read_file_path, "r")
    message = encrypted.read
    encrypted.close

    decrypted_text = @enigma.decrypt(message, key = (@key), date = (@date))
    decrypt = File.open(@write_file_path, "w")
    decrypt.write(decrypted_text[:decryption])
    puts "created 'decrypted.txt' with the key #{key} and date #{date}"

    decrypt.close
  end
end
