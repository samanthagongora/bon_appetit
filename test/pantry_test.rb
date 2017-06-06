require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def test_it_exists
    new_pantry = Pantry.new

    assert_instance_of Pantry, new_pantry
  end

  def test_stock_is_empty
    new_pantry = Pantry.new
    expected = {}
    actual = new_pantry.stock

    assert_equal expected, actual
  end

  def test_stock_check_returns_zero
    new_pantry = Pantry.new
    expected = 0
    actual = new_pantry.stock_check('Cheese')

    assert_equal expected, actual
  end

  def test_restock_can_stock_item
    new_pantry = Pantry.new
    new_pantry.restock('Cheese', 10)
    actual = new_pantry.stock_check('Cheese')
    expected = 10

    assert_equal expected, actual
  end

  def test_restock_can_stock_more_items
    new_pantry = Pantry.new
    new_pantry.restock('Cheese', 10)
    actual_1 = new_pantry.stock_check('Cheese')
    expected_1 = 10

    new_pantry.restock('Cheese', 20)
    actual_2 = new_pantry.stock_check('Cheese')
    expected_2 = 30

    assert_equal expected_1, actual_1
    assert_equal expected_2, actual_2
  end

  def test_pantry_can_convert_units
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)

    pantry = Pantry.new

    actual = pantry.convert_units(r)
    expected =
    {"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
     "Cheese"         => {quantity: 75, units: "Universal Units"},
     "Flour"          => {quantity: 5, units: "Centi-Units"}}

    assert_equal expected, actual
  end
end
