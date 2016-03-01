class PagesController < ApplicationController
  def home
    @User = User.all
  end	

end
