require 'test_helper'

class SupplementTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @supplement = supplements(:vitaminC)
  end

  test "should be valid" do
    assert @supplement.valid?
  end

  test "name should be present" do
    @supplement.name = "  "
    assert_not @supplement.valid?
  end

  test "name should not be too long" do
    @supplement.name = "a" * 51
    assert_not @supplement.valid?
  end

  test "description should not be too long" do
    @supplement.description = "a" * 501
    assert_not @supplement.valid?
  end

  test "name should be unique" do
    duplicate_supplement = @supplement.dup
    @supplement.save
    assert_not duplicate_supplement.valid?
  end
  
  test "associated reviews should be destroyed" do
    @supplement.save
    @supplement.reviews.create!(content: "Lorem ipsum", user: @user, score: 3)
    assert_difference 'Review.count', -2 do
      @supplement.destroy
    end
  end
  
end