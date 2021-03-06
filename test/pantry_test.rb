require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

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
    r = Recipe.new('Spicy Cheese Pizza')
    r.add_ingredient('Cayenne Pepper', 0.025)
    r.add_ingredient('Cheese', 75)
    r.add_ingredient('Flour', 500)

    pantry = Pantry.new

    actual = pantry.convert_units(r)
    expected =
      { 'Cayenne Pepper' => [{ quantity: 25, units: 'Milli-Units' }],
        'Cheese'         => [{ quantity: 75, units: 'Universal Units' }],
        'Flour'          => [{ quantity: 5, units: 'Centi-Units' }] }

    assert_equal expected, actual
  end

  def test_pantry_can_covert_mixed_units
    r = Recipe.new('Spicy Cheese Pizza')
    r.add_ingredient('Cayenne Pepper', 1.025)
    r.add_ingredient('Cheese', 75)
    r.add_ingredient('Flour', 550)
    pantry = Pantry.new

    actual = pantry.convert_units(r)
    expected = { 'Cayenne Pepper' => [{ quantity: 25, units: 'Milli-Units' },
                                      { quantity: 1, units: 'Universal Units' }],
                 'Cheese'         => [{ quantity: 75, units: 'Universal Units' }],
                 'Flour'          => [{ quantity: 5, units: 'Centi-Units' },
                                      { quantity: 50, units: 'Universal Units' }] }
    assert_equal expected, actual
  end

  def test_it_can_have_empty_shopping_list
    pantry = Pantry.new
    r = Recipe.new('Cheese Pizza')
    r.add_ingredient('Cheese', 20)
    r.add_ingredient('Flour', 20)

    actual = pantry.shopping_list
    expected = {}

    assert_equal expected, actual
  end

  def test_pantry_can_add_items_to_shopping_list
    pantry = Pantry.new
    r = Recipe.new('Cheese Pizza')
    r.add_ingredient('Cheese', 20)
    r.add_ingredient('Flour', 20)
    pantry.add_to_shopping_list(r)

    actual = pantry.shopping_list
    expected = { 'Cheese' => 20,
                 'Flour' => 20 }

    assert_equal expected, actual
  end

  def test_pantry_can_add_more_items_to_shopping_list
    pantry = Pantry.new
    r = Recipe.new('Cheese Pizza')
    r.add_ingredient('Cheese', 20)
    r.add_ingredient('Flour', 20)
    pantry.add_to_shopping_list(r)

    r_2 = Recipe.new('Spaghetti')
    r_2.add_ingredient('Noodles', 10)
    r_2.add_ingredient('Sauce', 10)
    r_2.add_ingredient('Cheese', 5)
    pantry.add_to_shopping_list(r_2)

    actual = pantry.shopping_list
    expected = { 'Cheese' => 25,
                 'Flour' => 20,
                 'Noodles' => 10,
                 'Sauce' => 10 }

    assert_equal expected, actual
  end

  def test_it_can_print_shopping_list
    pantry = Pantry.new
    r = Recipe.new('Cheese Pizza')
    r.add_ingredient('Cheese', 20)
    r.add_ingredient('Flour', 20)
    pantry.add_to_shopping_list(r)

    r_2 = Recipe.new('Spaghetti')
    r_2.add_ingredient('Noodles', 10)
    r_2.add_ingredient('Sauce', 10)
    r_2.add_ingredient('Cheese', 5)
    pantry.add_to_shopping_list(r_2)

    actual = pantry.print_shopping_list
    expected = "* Cheese: 25\n* Flour: 20\n* Noodles: 10\n* Sauce: 10"

    assert_equal expected, actual
  end
end
