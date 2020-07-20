require 'test_helper'

class SupplementTest < ActiveSupport::TestCase

  def setup
    @supplement = supplements(:vitaminC)
  end

  test "should be valid" do
    assert @supplement.valid?
  end

  test "name should be present" do
    @supplement.name = "  "
    assert_not @supplement.valid?
  end

end