require "./lib/enigma"

describe Enigma do
  before :each do
    @enigma = Enigma.new
  end

  it "exists" do
    expect(@enigma).to be_an(Enigma)
  end

  it "has a character set" do
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
                "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    expect(@enigma.characters).to eq(expected)
  end

  it "can generate todays date" do
    allow(@enigma).to receive(:date_generator).and_return(Date.parse("950804").strftime("%d%m%y"))
    expect(@enigma.date_generator).to eq("040895")
  end

  it "can generate random keys" do
    allow(@enigma).to receive(:key_generator).and_return("02715")
    expect(@enigma.key_generator).to eq("02715")
  end

  it "can generate offsets" do
    expect(@enigma.offset_generator("040895")).to eq("1025")
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
