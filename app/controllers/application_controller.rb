class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  def index
    current_user.articles
  end

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
