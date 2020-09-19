require 'test_helper'

class SupplementsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @supplement = supplements(:vitaminC)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get supplements_path
    assert_template 'supplements/index'
    assert_select 'div.pagination', count: 2
    last_page_of_supplements = Supplement.paginate(page: 3)
    last_page_of_supplements.each do |supplement|
      assert_select 'a[href=?]', supplement_path(supplement), text: supplement.name
    end
    assert_difference 'Supplement.count', -1 do
      delete supplement_path(@supplement)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get supplements_path
    assert_select 'a', text: 'delete', count: 0
  end
end