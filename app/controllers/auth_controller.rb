class AuthController < ApplicationController
  
  REALM = 'realm'.freeze
  USERS = {'user'.freeze => 'password'.to_sha1.freeze}

  def digest_auth
    # just for testing digest authentication
  end

private
  def authenticate
    authenticate_or_request_with_http_digest(REALM) do |username|
      USERS[username]
    end
  end
  
end
