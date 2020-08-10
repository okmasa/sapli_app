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
    # assert_match @supplement.reviews.count.to_s, response.body
    assert_select 'div.pagination'
    # gemfileがないエラー
    # review_item = assigns(:review_item)
    # review_item.paginate(page:1).each do |review|
    #   assert_match review.content, response.body
    # end
  end
end