require './lib/encrypt'
require './lib/enigma'

describe Encrypt do
  before :each do
    @encrypt = Encrypt.new("message.txt", "encrypted.txt")
  end

  it 'exists' do
    expect(@encrypt).to be_a(Encrypt)
  end

  it 'has a read file path and a write file path' do
    expect(@encrypt.read_file_path).to eq("message.txt")
    expect(@encrypt.write_file_path).to eq("encrypted.txt")
  end
end