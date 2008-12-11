class AlbumsController < ApplicationController
  def index
    @albums = Album.find(:all, :order => "title", :include => :tracks)
  end
  
  def play
    @album = Album.find(params[:id], :include => "tracks", :order => "tracks.sort_track_number")
    Clamp.play_album(@album.tracks)
    redirect_to :action => :index
  end
end
