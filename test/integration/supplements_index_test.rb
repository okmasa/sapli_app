require 'test_helper'

# class SupplementsIndexTest < ActionDispatch::IntegrationTest

#   def setup
#     @admin = users(:michael)
#     @non_admin =users(:archer)
#   end

#   test "index as admin including pagination and delete links" do
#     log_in_as(@admin)
#     get supplements_path
#     assert_template 'supplements/index'
#     assert_select 'div.pagination', count: 2
#     first_page_of_supplements = User.paginate(page: 1)
#     first_page_of_supplements.each do |supplement|
#       assert_select 'a[href=?]', supplement_path(supplement), text: supplement.name
#       unless user == @admin
#         assert_select 'a[href=?]', user_path(user), text: 'delete'
#       end
#     end
#     assert_difference 'supplement.count', -1 do
#       delete supplement_path(@non_admin)
#     end
#   end

#   test "index as non-admin" do
#     log_in_as(@non_admin)
#     get supplement_path
#     assert_select 'a', text: 'delete', count: 0
#   end
# end