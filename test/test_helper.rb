ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  
  def setup_digest_auth
    password = 'password'.to_sha1
    authenticate_with_http_digest('user', 'realm', password)
  end
  
end

# Allow http digest authentication in functional tests, based on https://gist.github.com/2764167
# Call authenticate_with_http_digest(user, realm, digest) or authenticate_with_http_digest(user, realm, password, false) before you perform a request
class ActionController::TestCase
  require 'digest/md5'
  
  def authenticate_with_http_digest(user, realm, password, password_is_ha1 = true)
    ActionController::Base.class_eval { include ActionController::Testing }
    
    @controller.instance_eval %Q(
      alias real_process_with_new_base_test process_with_new_base_test
      
      def process_with_new_base_test(request, response)
        credentials = {
          :uri => request.url,
          :realm => "#{realm}",
          :username => "#{user}",
          :nonce => ActionController::HttpAuthentication::Digest.nonce(request.env['action_dispatch.secret_token']),
          :opaque => ActionController::HttpAuthentication::Digest.opaque(request.env['action_dispatch.secret_token'])
        }
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Digest.encode_credentials(request.request_method, credentials, "#{password}", #{password_is_ha1})
        
        real_process_with_new_base_test(request, response)
      end
    )
  end
end
