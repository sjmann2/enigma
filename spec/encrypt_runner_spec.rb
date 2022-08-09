require "./lib/encrypt_runner"
require "./lib/enigma"

describe EncryptRunner do
  before :each do
    @encrypt_runner = EncryptRunner.new("message.txt", "encrypted.txt")
  end

  it "exists" do
    expect(@encrypt_runner).to be_an(EncryptRunner)
  end

  it "has a read file path and a write file path" do
    expect(@encrypt_runner.read_file_path).to eq("message.txt")
    expect(@encrypt_runner.write_file_path).to eq("encrypted.txt")
  end

  it "has a run method" do
    allow_any_instance_of(EncryptRunner).to receive(:run).and_return("created 'decrypted.txt' with the key 02715 and date 040895")
  end

  it "can read a file" do
    message_file = double(File, read: "stubbed read")
    allow_any_instance_of(File).to receive(:open).and_return("stubbed read")
  end

  it "can encrypt a message" do
    message = "hello world"
    key = double("key")
    enigma = double("enigma")
    date = double("date")
    allow(enigma).to receive(:encrypt).and_return("keder ohulw")
    expect(enigma.encrypt(message, key, date)).to eq("keder ohulw")
  end

end
