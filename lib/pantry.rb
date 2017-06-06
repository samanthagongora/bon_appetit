class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(item)
    return 0 if self.stock[item].nil?
    self.stock[item]
  end
end
