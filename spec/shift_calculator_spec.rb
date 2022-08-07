require "./shift_calculator"

describe ShiftCalculator do
  before :each do
    @shift_calculator = ShiftCalculator.new
  end

  it 'exists' do
    expect(@shift_calculator).to be_a(ShiftCalculator)
  end

  it "can generate todays date" do
    allow(@shift_calculator).to receive(:date_generator).and_return(Date.parse("950804").strftime("%d%m%y"))
    expect(@shift_calculator.date_generator).to eq("040895")
  end

  it "can generate random keys" do
    allow(@shift_calculator).to receive(:key_generator).and_return("02715")
    expect(@shift_calculator.key_generator).to eq("02715")
  end

  it "can calculate offsets" do
    expect(@shift_calculator.offset_calculator("040895")).to eq("1025")
  end

  it "can calculate shift values" do
    expected = { a_shift: 93,
      b_shift: 53,
      c_shift: 75,
      d_shift: 27

    }
    allow(@shift_calculator).to receive(:key_generator).and_return("84721")
    allow(@shift_calculator).to receive(:date_generator).and_return(Date.parse("220806").strftime("%d%m%y"))
    expect(@shift_calculator.shift_calculator("84721", "220806")).to eq(expected)
  end
end