require 'test_helper'

class ChartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get charts_index_url
    assert_response :success
  end

  test "should get new" do
    get charts_new_url
    assert_response :success
  end

  test "should get edit" do
    get charts_edit_url
    assert_response :success
  end

end
