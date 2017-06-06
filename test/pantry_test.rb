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
end
