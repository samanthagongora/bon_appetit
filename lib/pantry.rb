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
    return @stock[item] = quantity if @stock[item].nil?
    @stock[item] += quantity
  end

  def convert_units(recipe)
    ingredients = recipe.ingredients
    ingredients.map do |i, q|
      if q < 2
        ingredients[i] = mixed_milli_units(q) if q > 1
        ingredients[i] = milli_units(q) if q < 1
      elsif q > 100
        ingredients[i] = mixed_centi_units(q) if q % 100 != 0
        ingredients[i] = centi_units(q) if q % 100 == 0
      else
        ingredients[i] = [{ quantity: q, units: 'Universal Units' }]
      end
    end
    ingredients
  end

  def mixed_milli_units(q)
    remainder = q % 1
    quotient = q - remainder
    [{ quantity: (remainder * 1000).round, units: 'Milli-Units' },
     { quantity: quotient.round, units: 'Universal Units' }]
  end

  def milli_units(q)
    [{ quantity: (q * 1000).round, units: 'Milli-Units' }]
  end

  def mixed_centi_units(q)
    remainder = q % 100
    quotient = q - remainder
    [{ quantity: (quotient / 100), units: 'Centi-Units' },
     { quantity: remainder, units: 'Universal Units' }]
  end

  def centi_units(q)
    [{ quantity: (q / 100), units: 'Centi-Units' }]
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

  def print_shopping_list
    human_readable = ''
    items = @shopping_list.keys
    items.each_with_index do |item, idx|
      if items[idx + 1].nil?
        human_readable << "* #{item}: #{@shopping_list[item]}"
      else
        human_readable << "* #{item}: #{@shopping_list[item]}\n"
      end
    end
    human_readable
  end
end
