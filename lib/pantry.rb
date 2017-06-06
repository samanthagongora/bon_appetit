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
    ingredients.each do |i, q|
      if q < 1
        converted_units[i] = {quantity: (q * 1000), units: "Milli-Units"}
      elsif q > 100
        converted_units[i] = {quantity: (q / 100), units: "Centi-Units"}
      else
        converted_units[i] = {quantity: q, units: "Universal Units"}
      end
    end
    converted_units
  end

  def add_to_shopping_list(recipe)
    ingredients = recipe.ingredients

    ingredients.each do |i, q|
      if @shopping_list[i].nil?
        @shopping_list[i] = q
      else
        @shopping_list[i] += q
      end
    end
  end
end
