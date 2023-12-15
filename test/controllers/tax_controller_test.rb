require "test_helper"

class TaxControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get tax_edit_url
    assert_response :success
  end
end
