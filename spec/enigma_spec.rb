require "./lib/enigma"
require "./lib/shift_calculator"
require "./lib/convertable"

describe Enigma do
  before :each do
    @enigma = Enigma.new
    @enigma.extend(Convertable)
  end

  it "exists" do
    expect(@enigma).to be_an(Enigma)
  end

  it "has a character set" do
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
                "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    expect(@enigma.characters).to eq(expected)
  end

  it "can find index values within the characters array of a given message" do
    expect(@enigma.convert_to_index_values("hello world")).to eq([7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3])
  end

  it "can take the index values of the character array and convert them to an encrypted message" do
    expect(@enigma.convert_to_index_values("hello world")).to eq([7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3])
    expect(@enigma.convert_to_encrypted_message("hello world", "02715", "040895")).to eq("keder ohulw")
  end

  it "can encrypt a message given a key and a date" do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.convert_to_index_values("hello world")).to eq([7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3])
    expect(@enigma.convert_to_encrypted_message("hello world", "02715", "04895")).to eq("keder ohulw")
    expect(@enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
  end

  it "can encrypt a message given a key and no date" do
    expected = {
      date: "060822",
      encryption: "okjdvfugyrb",
      key: "02715",
    }
    allow(@enigma.shift_calculator).to receive(:date_generator).and_return(Date.parse("220806").strftime("%d%m%y"))
    expect(@enigma.encrypt("hello world", "02715")).to eq(expected)
  end

  it "can encrypt a message given no key or date" do
    expected = {
      date: "060822",
      encryption: "ioempjppsvx",
      key: "23124",
    }
    allow(@enigma.shift_calculator).to receive(:key_generator).and_return("23124")
    allow(@enigma.shift_calculator).to receive(:date_generator).and_return(Date.parse("220806").strftime("%d%m%y"))
    expect(@enigma.encrypt("hello world")).to eq(expected)
  end

  it "can find decrypted index values of a given message" do
    expect(@enigma.convert_to_index_values("keder ohulw")).to eq([10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22])
    expect(@enigma.convert_to_decrypted_message("keder ohulw", "02715", "040895")).to eq("hello world")
  end

  it "can decrypt a message given a key and a date" do
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.convert_to_index_values("keder ohulw")).to eq([10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22])
    expect(@enigma.convert_to_decrypted_message("keder ohulw", "02715", "040895")).to eq("hello world")
    expect(@enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
  end

  it "can decrypt a message given only a message and a key" do
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
      encryption: "ke&eoosprrdx!",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.encrypt("he&llo world!", "02715", "040895")).to eq(expected)
  end

  it "can decrypt a message and leave a character not included in the character set" do
    expected = {
      decryption: "he&llo world!",
      key: "02715",
      date: "040895",
    }
    expect(@enigma.decrypt("ke&eoosprrdx!", "02715", "040895")).to eq(expected)
  end
end
