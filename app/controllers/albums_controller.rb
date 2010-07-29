class AlbumsController < ApplicationController  
  def index
    @albums = Album.paginate(:all, :order => "title", :include => :tracks, :page => params[:page], :per_page => 15)
  end
  
  def play
    @album = Album.find(params[:id], :include => "tracks", :order => "tracks.sort_track_number")
    PLAYER.new.play_album(@album.tracks)
    render :nothing => true
  end
end
