Kyoto::Application.routes.draw do
  
  post 'digest_auth' => 'auth#digest_auth'
  
end
