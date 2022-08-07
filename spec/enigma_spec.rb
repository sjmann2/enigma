require "./lib/enigma"

describe Enigma do
  before :each do
    @enigma = Enigma.new
    @enigma.extend(Generatable)
    @enigma.extend(Calculatable)
  end

  it "exists" do
    expect(@enigma).to be_an(Enigma)
  end

  it "has a character set" do
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
                "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    expect(@enigma.characters).to eq(expected)
  end

  

  it "can find index values within characters array of a given message" do
    message = "hello world"
    expect(@enigma.find_character_index_values(message)).to eq([7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3])
  end

  it "can find encrypted index values of a given message" do
    message = "hello world"
    key = "02715"
    date = "040895"
    expect(@enigma.find_character_index_values(message)).to eq([7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3])
    expect(@enigma.find_encrypted_index_values(message, key, date)).to eq([10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22])
  end

  it "can encrypt a message given a key and a date" do
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
    allow(@enigma).to receive(:date_generator).and_return(Date.parse("220806").strftime("%d%m%y"))
    expect(@enigma.encrypt("hello world")).to eq(expected)
  end

  it "can find decrypted index values of a given message" do
    message = "keder ohulw"
    key = "02715"
    date = "040895"
    expect(@enigma.find_character_index_values(message)).to eq([10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22])
    expect(@enigma.find_decrypted_index_values(message, key, date)).to eq([7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3])
  end

  it "can decrypt a message given a key and a date" do
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

  it "can encrypt a message and leave a character not included in the character set" do
    expected = {
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.encrypt("hello world!", "02715", "040895")).to eq(expected)
  end

  it "can decrypt a message and leave a character not included in the character set" do
    expected = {
      decryption: "hello world!",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.decrypt("keder ohulw!", "02715", "040895")).to eq(expected)
  end
end
