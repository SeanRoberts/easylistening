class PlayerController < ApplicationController
  def now_playing
    render :partial => "shared/now_playing"
  end
end
