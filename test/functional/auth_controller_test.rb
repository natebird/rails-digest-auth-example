require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "a POST to :digest_auth with proper authentication" do
    setup_digest_auth
    post :digest_auth
      
    assert_response :success
  end

end
