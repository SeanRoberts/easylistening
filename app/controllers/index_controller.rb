class IndexController < ApplicationController
  def index
    @tracks = Track.paginate(:include => [:artist, :album], :order => "albums.title, tracks.sort_track_number", :per_page => 200, :page => params[:page])
  end
  
  def play
    Itunes::play()
  end
end
