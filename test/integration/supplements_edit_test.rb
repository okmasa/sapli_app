require 'test_helper'

class SupplementsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @supplement = supplements(:vitaminC)
  end

  test "unsuccessful edit" do
    log_in_as @user
    get edit_supplement_path(@supplement)
    assert_template 'supplements/edit'
    patch supplement_path(@supplement), params: { supplement: { name:  "",
                                                                description: " "} }
    assert_template 'supplements/edit'
  end

  test "successful edit" do
    log_in_as @user
    get edit_supplement_path(@supplement)
    assert_template 'supplements/edit'
    name  = "testsapli"
    description = "hogehoge"
    patch supplement_path(@supplement), params: { supplement: { name:  name,
                                              description: description} }
    assert_not flash.empty?
    assert_redirected_to @supplement
    @supplement.reload
    assert_equal name,  @supplement.name
    assert_equal description,  @supplement.description
  end
end