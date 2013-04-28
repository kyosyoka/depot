require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get inex" do
    get :inex
    assert_response :success
  end

end
