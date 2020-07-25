require 'test_helper'

class SupplementsControllerTest < ActionDispatch::IntegrationTest

def setup
  @user       = users(:michael)
  @other_user = users(:archer)
  @supplement = supplements(:vitaminC)
end

test "should get index" do
  get supplements_path
  assert_response :success
end

test "should redirect edit when not logged in" do
  get edit_supplement_path(@supplement)
  assert_not flash.empty?
  assert_redirected_to login_url
end

test "should redirect update when not logged in" do
  patch supplement_path(@supplement), params: { supplement: { name: @supplement.name,
                                                description: @supplement.description } }
  assert_not flash.empty?
  assert_redirected_to login_url
end

test "should redirect destroy when logged in as a non-admin" do
  log_in_as(@other_user)
  assert_no_difference 'Supplement.count' do
    delete supplement_path(@supplement)
  end
  assert_redirected_to root_url
end

end