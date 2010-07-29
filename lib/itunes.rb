class Itunes
  require 'rbosa'
  
  def initialize
    # open iTunes in the background if it's not already running
    `open -g -a iTunes`
    
    @itunes = OSA.app('iTunes')
    create_playlist
  end
  
  def create_playlist
    @playlist = @itunes.sources[0].playlists.select { |p| p.name == "EasyListeningPL" }[0] || @itunes.make(OSA::ITunes::Playlist, nil, {:name => "EasyListeningPL"})
  end
  
  def clear_playlist
    if @playlist.tracks.length > 0
      @itunes.delete @playlist
      create_playlist
    end
  end
  
  def play(path)
    clear_playlist
    @itunes.add(path, :to => @playlist)
    @itunes.stop
    @itunes.play(@playlist)
  end
  
  def play_album(tracks)
    clear_playlist
    tracks.each { |t| @itunes.add(t.path, :to => @playlist) }
    @itunes.play(@playlist)
  end
  
  def current_track
    Track.find_by_path(@itunes.current_track.get.location)
  end
  
  def player_state
    @itunes.player_state
  end
  
  def player_position
    @itunes.player_position
  end
  
  def track_duration
    @itunes.current_track.duration
  end
end