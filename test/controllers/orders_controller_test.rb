require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orders_index_url
    assert_response :success
  end

  test "should get show" do
    get orders_show_url
    assert_response :success
  end

  test "should get admin" do
    get orders_admin_url
    assert_response :success
  end

  test "should get admin_show" do
    get orders_admin_show_url
    assert_response :success
  end
end
