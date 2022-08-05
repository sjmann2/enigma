require "./lib/enigma"

describe Enigma do
  before :each do
    @enigma = Enigma.new
  end

  it "exists" do
    expect(@enigma).to be_an(Enigma)
  end

  it "can generate random keys" do
    expect(@enigma.key_generator).to eq(02715)
  end

  it "can generate offsets" do
    expect(@enigma.offset_generator).to eq(1025)
  end

  it "can encrypt a message" do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
  end

  it "can decrypt a message" do
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
  end

  it "can encrypt capital letters to lowercase" do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.encrypt("HELLO WORLD", "02715", "040895")).to eq(expected)
  end

  it "can encrypt a message and ignore a character not in the character set" do
    expected = {
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.encrypt("hello world!", "02715", "040895")).to eq(expected)
  end
end
