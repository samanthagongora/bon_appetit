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
    actual = new_pantry.stock_check("Cheese")

    assert_equal expected, actual
  end

  def test_restock_can_stock_item
    new_pantry = Pantry.new
    new_pantry.restock("Cheese", 10)
    actual = new_pantry.stock_check("Cheese")
    expected = 10

    assert_equal expected, actual
  end

  def test_restock_can_stock_more_items
    new_pantry = Pantry.new
    new_pantry.restock("Cheese", 10)
    actual_1 = new_pantry.stock_check("Cheese")
    expected_1 = 10

    new_pantry.restock("Cheese", 20)
    actual_2 = new_pantry.stock_check("Cheese")
    expected_2 = 30

    assert_equal expected_1, actual_1
    assert_equal expected_2, actual_2
  end
end
