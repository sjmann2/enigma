require './lib/decrypt'
require './lib/enigma'

describe Decrypt do
  before :each do
    @decrypt = Decrypt.new("encrypted.txt", "decrypted.txt", 82648, 240818)
  end

  it 'exists' do
    expect(@decrypt).to be_a(DecryptRunner)
  end

  it 'has a read file path, write file path, key, and date' do
    expect(@decrypt.read_file_path).to eq("encrypted.txt")
    expect(@decrypt.write_file_path).to eq("decrypted.txt")
    expect(@decrypt.key).to eq(82648)
    expect(@decrypt.date).to eq(240818)
  end
end