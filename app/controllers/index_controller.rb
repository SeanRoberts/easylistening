class IndexController < ApplicationController
  require 'clamp'
  
  def index
    @tracks = Track.paginate(:include => [:artist, :album], :order => "albums.title, tracks.sort_track_number", :per_page => 200, :page => params[:page])
  end
  
  def play
    @track = Track.find(params[:id])
    Clamp.run('plclear')
    Clamp.run('load', @track.path)
    Clamp.run('play')
    redirect_to :action => :index
  end
end
