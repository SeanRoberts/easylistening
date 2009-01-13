class AlbumsController < ApplicationController
  require 'clamp'
  
  def index
    @albums = Album.paginate(:all, :order => "title", :include => :tracks, :page => params[:page], :per_page => 50)
  end
  
  def play
    @album = Album.find(params[:id], :include => "tracks", :order => "tracks.sort_track_number")
    Clamp.new.play_album(@album.tracks)
    redirect_to :action => :index
  end
end
