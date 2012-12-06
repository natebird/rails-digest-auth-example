class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Digest::ControllerMethods
  before_filter :authenticate
end
