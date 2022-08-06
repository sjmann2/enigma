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
    expect(@enigma.offset_calculator("040895")).to eq("1025")
  end

  it "can generate shift values" do
    expected = { a_shift: 93,
      b_shift: 53,
      c_shift: 75,
      d_shift: 27

    }
    allow(@enigma).to receive(:key_generator).and_return("84721")
    allow(@enigma).to receive(:date_generator).and_return(Date.parse("220806").strftime("%d%m%y"))
    expect(@enigma.shift_calculator("84721", "220806")).to eq(expected)
  end

  it "can encrypt a message" do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
  end

  it "can encrypt a message given a key and no date" do
    expected = {
      date: "060822",
      encryption: "okjdvfugyrb",
      key: "02715",
    }
    allow(@enigma).to receive(:date_generator).and_return(Date.parse("220806").strftime("%d%m%y"))
    expect(@enigma.encrypt("hello world", "02715")).to eq(expected)
  end

  it "can encrypt a message given no key or date" do
    expected = {
      date: "060822",
      encryption: "ioempjppsvx",
      key: "23124",
    }
    allow(@enigma).to receive(:key_generator).and_return("23124")
    expect(@enigma.encrypt("hello world")).to eq(expected)
  end

  it "can decrypt a message" do
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
  end

  it "can decrypt a message given only a cipher a key" do
    encrypted = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.decrypt(encrypted[:encryption], "02715"))
  end

  it "can encrypt capital letters to lowercase" do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.encrypt("HELLO WORLD", "02715", "040895")).to eq(expected)
  end

  xit "can encrypt a message and ignore a character not in the character set" do
    expected = {
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.encrypt("hello world!", "02715", "040895")).to eq(expected)
  end
end
