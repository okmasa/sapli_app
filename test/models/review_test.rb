require 'test_helper'

class ReviewTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @supplement = supplements(:vitaminC)
    @review = @user.reviews.build(content: "Lorem ipsum",
                                  supplement: @supplement,
                                  score: 1)
  end

  test "should be valid" do
    assert @review.valid?
  end
  
  test "user id should be present" do
    @review.user_id = nil
    assert_not @review.valid?
  end

  test "supplement id should be present" do
    @review.supplement_id = nil
    assert_not @review.valid?
  end

  # test "content should be present" do
  #   @review.content = "   "
  #   assert_not @review.valid?
  # end
  
  test "score should be present" do
    @review.score = nil
    assert_not @review.valid?
  end

  test "score should be 0 to 5" do
    @review.score = 6
    assert_not @review.valid?
    @review.score = 0.5
    assert @review.valid?
  end

  test "content should be at most 140 characters" do
    @review.content = "a" * 141
    assert_not @review.valid?
  end

  test "order should be most recent first" do
    assert_equal reviews(:most_recent), Review.first
  end

end