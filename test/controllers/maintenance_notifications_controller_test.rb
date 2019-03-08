require 'test_helper'

class MaintenanceNotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get maintenance_notifications_show_url
    assert_response :success
  end

end
