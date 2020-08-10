require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest

  test "create should require logged_in user" do
    assert_no_difference 'Favorite.count' do
      post favorites_path
    end
    assert_redirected_to login_url
  end

  test "destroy should require logged_in user" do
    assert_no_difference 'Favorite.count' do
      delete supplement_favorites_path(favorites(:one))
    end
    assert_redirected_to login_url
  end

end
