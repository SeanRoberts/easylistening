class TracksController < ApplicationController  
  def index
    @tracks = Track.paginate(:include => [:artist, :album], :order => "albums.title, tracks.sort_track_number", :per_page => 200, :page => params[:page])
  end
  
  def play
    @track = Track.find(params[:id])
    PLAYER.new.play(@track.path)
    render :nothing => true
  end
  

end
