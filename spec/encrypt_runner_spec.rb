require './lib/encrypt_runner'
require './lib/enigma'

describe EncryptRunner do
  before :each do
    @encrypt_runner = EncryptRunner.new("message.txt", "encrypted.txt")
  end

  it 'exists' do
    expect(@encrypt_runner).to be_a(EncryptRunner)
  end

  it 'has a read file path and a write file path' do
    expect(@encrypt_runner.read_file_path).to eq("message.txt")
    expect(@encrypt_runner.write_file_path).to eq("encrypted.txt")
  end
end