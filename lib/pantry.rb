require 'pry'
require './lib/recipe'

class Pantry
  attr_reader :stock,
              :shopping_list
  def initialize
    @stock = {}
    @shopping_list = {}
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

  def convert_units(recipe)
    ingredients = recipe.ingredients
    converted_units = {}
    ingredients.each do |k,v|
      if v < 1
        converted_units[k] = {quantity: (v * 1000), units: "Milli-Units"}
      elsif v > 100
        converted_units[k] = {quantity: (v / 100), units: "Centi-Units"}
      else
        converted_units[k] = {quantity: v, units: "Universal Units"}
      end
    end
    converted_units
  end
end
