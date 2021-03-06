class Clamp
  @@path = CONFIG["path_to_clamp"]
  
  def initialize()
    system(@@path + " /START")
    sleep 1
  end


  def run(command, arguments = '')
    arguments.gsub!(/&&|\||;/, '')
    puts "#{command} not recognized" and return false unless COMMANDS[command.upcase]
    cmd = "#{@@path} /#{command}" 
    cmd += ' "' + arguments + '"' unless arguments.blank?
    system(cmd)
  end

  def play(path)
    self.run('PLCLEAR')
    self.run('PLADD', path)
    self.run('PLFIRST')
    self.run('PLAY')
  end

  def play_album(tracks)
    self.run('plclear')
    tracks.each { |track| self.run('pladd', track.launch_path) }
    self.run('plfirst')
    self.run('play')
  end

  COMMANDS = {
    # General
    "START" => "Start Winamp",
    "QUIT" =>  "Exit Winamp",
    "RESTART" =>" => ""Restart Winamp",
    "PLAY" =>" => ""Play (current file) - Quits Stopped or Pause mode",
    "STOP" => "Stop playing",
    "STOPFADE" => "Stop playing with fadout",
    "STOPAFTER" => "Stop playing after current track (returns now, stops later)",
    "PAUSE" => "Toggle pause mode",
    "PAUSE ON|OFF" => "Sets pause mode",
    "PLAYPAUSE" => "Same as PAUSE",
    "NEXT" => "Play next song",
    "PREV" => "Play previous song",
    "FWD" => "Forward 5 seconds",
    "REW" => "Rewind 5 seconds",
    "JUMP" => "Seek to <time> (in millisecs)",
    "QUITAFTER" => "Close winamp upon completion of current track - CLAmp will not return immediately",

    # Playlists
    "PLADD" => "Add file(s) to end of playlist (like drag-n-drop)",
    "LOAD" => "Same as above",
    "PLCLEAR" => "Clear Playlist",
    "CLEAR" => "Same as above",
    "PL" => "Show/Hide Winamp Playlist window",
    "PLWIN" => "Same as above",
    "PLPOS" => "Query Playlist position (requires Winamp 2.05+)",
    "PLFIRST" => "Play first item of playlist",
    "PLLAST" => "Play last item of playlist",
    "PLSET <num>" => "Set current playlist item (note this does not interfere with curring playing, if needed, use /PLAY after to go to this item)",
    "PLSET RANDOM" => "Set current playlist item to a random item within playlist",
    "SETPLPOS" => "Same as PLSET",
    "LOADNEW <file>" => "Same as /PLCLEAR /PLADD <file>",
    "LOADPLAY <file>" => "Shortcut for /PLCLEAR /PLADD <file> /PLAY",
    "PLSAVE <file>" => "Saves current playlist to <file> (as a M3U file)",


    # Winamp Volume Control
    "VOLUP"  => "Volume up",
    "VOLDN"  =>   "Volume down",
    "VOLSET"  =>   "Volume set (scale 0-255)",
    "VOL=<value>"  =>   "Volume set (scale 0-100)",
    "VOLMAX"  =>   "Volume max",
    "VOLMIN"  =>  "Volume min (no sound)"
  }
end
