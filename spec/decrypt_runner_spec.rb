require "./lib/decrypt_runner"
require "./lib/enigma"

describe DecryptRunner do
  before :each do
    @decrypt_runner = DecryptRunner.new("encrypted.txt", "decrypted.txt", 82648, 240818)
  end

  it "exists" do
    expect(@decrypt_runner).to be_a(DecryptRunner)
  end

  it "has a read file path, write file path, key, and date" do
    expect(@decrypt_runner.read_file_path).to eq("encrypted.txt")
    expect(@decrypt_runner.write_file_path).to eq("decrypted.txt")
    expect(@decrypt_runner.key).to eq(82648)
    expect(@decrypt_runner.date).to eq(240818)
  end
end
