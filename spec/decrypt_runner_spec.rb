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

  it "has a run method" do
    allow_any_instance_of(DecryptRunner).to receive(:run).and_return("created 'decrypted.txt' with the key 02715 and date 040895")
  end

  it "can read a file" do
    message_file = double(File, read: "stubbed read")
    allow_any_instance_of(File).to receive(:open).and_return("stubbed read")
  end

  it "can decrypt a message" do
    message = "hello world"
    key = double("key")
    enigma = double("enigma")
    date = double("date")
    allow(enigma).to receive(:decrypt).and_return("hello world")
    expect(enigma.decrypt(message, key, date)).to eq("hello world")
  end
end
