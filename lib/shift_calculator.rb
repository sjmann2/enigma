require "date"

class ShiftCalculator
  def initialize
  end

  def date_generator
    Date.today.strftime("%d%m%y")
  end

  def key_generator
    5.times.map { rand(10) }.join
  end

  def offset_calculator(date)
    squared_date = (date.to_i ** 2).to_s
    squared_date[-4..-1]
  end

  def shift_calculator(key, date)
    offset = offset_calculator(date)

    shifts = {
      a_shift: (key[0] + key[1]).to_i + offset[0].to_i,
      b_shift: (key[1] + key[2]).to_i + offset[1].to_i,
      c_shift: (key[2] + key[3]).to_i + offset[2].to_i,
      d_shift: (key[3] + key[4]).to_i + offset[3].to_i,
    }
  end
end
