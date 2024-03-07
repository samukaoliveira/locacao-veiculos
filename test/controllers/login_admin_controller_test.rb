require "test_helper"

class LoginAdminControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get login_admin_login_url
    assert_response :success
  end

  test "should get logar" do
    get login_admin_logar_url
    assert_response :success
  end
end
