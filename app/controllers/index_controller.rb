class IndexController < ApplicationController
  require 'clamp'
  
  def index
    @tracks = Track.paginate(:include => [:artist, :album], :order => "albums.title, tracks.sort_track_number", :per_page => 200, :page => params[:page])
  end
  
  def play
    @track = Track.find(params[:id])
    Clamp.play(@track.path)
    redirect_to :action => :index
  end
  
  def play_album
    @album = Album.find(params[:id], :include => "tracks", :order => "tracks.sort_track_number")
    Clamp.play_album(@album.tracks)
    redirect_to :action => :index
  end
end
