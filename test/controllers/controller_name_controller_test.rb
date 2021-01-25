require 'test_helper'

class ControllerNameControllerTest < ActionDispatch::IntegrationTest
  test "should get new_projects" do
    get controller_name_new_projects_url
    assert_response :success
  end

end
