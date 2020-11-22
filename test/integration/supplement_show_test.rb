require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  include ActionDispatch::TestProcess

  def setup
    @user = users(:michael)
    @supplement = supplements(:example_sapli)
  end

  test "supplement_show display" do
    get supplement_path(@supplement)
    assert_template 'supplements/show'
    assert_select 'title', "#{@supplement.name} | サプリアプリ"
    assert_select 'h1', text: @supplement.name
    assert_select 'img'
    assert_match @supplement.name, response.body
    assert_match @supplement.reviews.count.to_s, response.body
    assert_select 'div.pagination'
    assert_match @supplement.reviews.last.content, response.body
    # gemfileがないエラー
    # review_item = assigns(:review_item)
    # review_item.paginate(page:1).each do |review|
    #   assert_match review.content, response.body
    # end
  end

  # test "valid review" do
  #   assert_difference 'Review.count', 1 do
  #     post reviews_path, params: { review: 
  #                                   { content: "content",  user: @user,
  #                                     supplement: @supplement } }
  #   end
  # end

  test "invalid review should redirect" do
    assert_no_difference 'Review.count', 1 do
    post reviews_path, params: { review: 
                                  { content: "content",
                                    supplement: @supplement } }
    end
    assert_redirected_to login_url
  end

end