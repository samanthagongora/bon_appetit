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
    recipe.ingredients.map do |i, quantity|
      recipe.ingredients[i] = if quantity < 2
                                convert_milli_units(quantity)
                              elsif quantity > 100
                                convert_centi_units(quantity)
                              else
                                return_universal_units(quantity)
                              end
    end
    recipe.ingredients
  end

  def convert_milli_units(quantity)
    return mixed_milli_units(quantity) if quantity > 1
    milli_units(quantity)
  end

  def mixed_milli_units(quantity)
    remainder = quantity % 1
    quotient = quantity - remainder
    [{ quantity: (remainder * 1000).round, units: 'Milli-Units' },
     { quantity: quotient.round, units: 'Universal Units' }]
  end

  def milli_units(quantity)
    [{ quantity: (quantity * 1000).round, units: 'Milli-Units' }]
  end

  def convert_centi_units(quantity)
    return mixed_centi_units(quantity) if quantity % 100 != 0
    centi_units(quantity)
  end

  def mixed_centi_units(quantity)
    remainder = quantity % 100
    quotient = quantity - remainder
    [{ quantity: (quotient / 100), units: 'Centi-Units' },
     { quantity: remainder, units: 'Universal Units' }]
  end

  def centi_units(quantity)
    [{ quantity: (quantity / 100), units: 'Centi-Units' }]
  end

  def return_universal_units(quantity)
    [{ quantity: quantity, units: 'Universal Units' }]
  end

  def add_to_shopping_list(recipe)
    ingredients = recipe.ingredients
    ingredients.map do |item, quantity|
      @shopping_list[item] = 0 if @shopping_list[item].nil?
      @shopping_list[item] += quantity
    end
  end

  def print_shopping_list
    items = @shopping_list.keys
    collection = items.map.with_index do |item, idx|
      item = if items[idx + 1].nil?
               "* #{item}: #{@shopping_list[item]}"
             else
               "* #{item}: #{@shopping_list[item]}\n"
             end
    end
    collection.join('')
  end
end
