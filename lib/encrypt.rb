require_relative "./enigma"
require_relative "./encrypt_runner"

runner = EncryptRunner.new(ARGV[0], ARGV[1])

runner.run
