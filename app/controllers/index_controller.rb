class IndexController < ApplicationController
  def index
    @count = {:albums => Album.count, :artists => Artist.count, :tracks => Track.count}
  end
end