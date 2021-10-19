require "test_helper"

class SalesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get sales_show_url
    assert_response :success
  end

  test "should get addItem" do
    get sales_addItem_url
    assert_response :success
  end

  test "should get removeItem" do
    get sales_removeItem_url
    assert_response :success
  end

  test "should get calculate" do
    get sales_calculate_url
    assert_response :success
  end
end
