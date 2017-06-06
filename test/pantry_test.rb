require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def test_it_exists
    new_pantry = Pantry.new

    assert_instance_of Pantry, new_pantry
  end
end
