require "./lib/encrypt_runner"
require "./lib/enigma"
require "./lib/shift_calculator"

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
    encrypt_runner = double("files")
    
    allow(encrypt_runner).to receive(:run).and_return("created 'encrypted.txt' with the key 02715 and date 040895")
  end
end
