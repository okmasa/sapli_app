require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  def setup
    @favorite = Favorite.new(user_id: users(:michael).id,
                             supplement_id: supplements(:vitaminC).id)
  end

  test "should be valid" do
    assert @favorite.valid?
  end

  test "should require user_id" do
    @favorite.user_id =nil
    assert_not @favorite.valid?
  end

  test "should require supplement_id" do
    @favorite.supplement_id = nil
    assert_not @favorite.valid?
  end

end
