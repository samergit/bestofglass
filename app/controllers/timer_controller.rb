class TimerController < ApplicationController
  def auction_timer
    respond_to do |format|
      format.html
      format.js
    end
  end
end
