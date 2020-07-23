require 'test_helper'

class SupplementsControllerTest < ActionDispatch::IntegrationTest

test "should get new" do
  get register_path
  assert_response :success
end

end