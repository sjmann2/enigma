require_relative './enigma'
require_relative './decrypt_runner'

runner = DecryptRunner.new(ARGV[0], ARGV[2], ARGV[3], ARGV[1])

runner.run