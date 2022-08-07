class EncryptRunner
  attr_reader :read_file_path,
              :write_file_path

  def initialize(read_file_path, write_file_path)
    @read_file_path = read_file_path
    @write_file_path = write_file_path
    @enigma = Enigma.new
  end

  def run
    message_file = File.open(read_file_path, "r")
    message = message_file.read
    message_file.close

    encrypted_text = @enigma.encrypt(message, key = @enigma.key_generator, date = @enigma.date_generator)

    encrypt = File.open(write_file_path, "w")

    encrypt.write(encrypted_text[:encryption])
    puts "created 'encrypted.txt' with the key #{key} and date #{date}"

    encrypt.close
  end
end
