module Generatable
  def date_generator
    Date.today.strftime("%d%m%y")
  end

  def key_generator
    5.times.map { rand(10) }.join
  end
end
