require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get edit_about" do
    get admin_edit_about_url
    assert_response :success
  end

  test "should get update_about" do
    get admin_update_about_url
    assert_response :success
  end

  test "should get edit_contact" do
    get admin_edit_contact_url
    assert_response :success
  end

  test "should get update_contact" do
    get admin_update_contact_url
    assert_response :success
  end
end
