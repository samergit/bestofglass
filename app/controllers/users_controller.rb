class UsersController < ApplicationController
  def profile
    @user = User.find_by_username(params[:username])
  end
end