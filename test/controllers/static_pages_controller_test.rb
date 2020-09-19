require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "ホーム | サプリアプリ"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "使い方 | サプリアプリ"
  end
  
end