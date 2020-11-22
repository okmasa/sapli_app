require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @review = reviews(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Review.count' do
      post reviews_path, params: { review: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Review.count' do
      delete review_path(@review)
    end
    assert_redirected_to login_url
  end
end