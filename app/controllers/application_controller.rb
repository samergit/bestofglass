class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :banned?
  before_filter :record_user_activity

  def check_auction_privileges!
    redirect_to root_path unless current_user.admin? 
  end

  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      redirect_to access_denied_path
    end
  end

  
  def record_user_activity
    if current_user
      current_user.touch :last_active_at
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :instagram, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end


end
