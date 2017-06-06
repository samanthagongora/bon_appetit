require 'pry'

class Pantry

  attr_reader :stock
  def initialize
    @stock = {}
  end

  def stock_check(item)
    return 0 if @stock[item].nil?
    @stock[item]
  end

  def restock(item, quantity)
    if @stock[item].nil?
      @stock[item] = quantity
    else
      @stock[item] += quantity
    end
  end
end
