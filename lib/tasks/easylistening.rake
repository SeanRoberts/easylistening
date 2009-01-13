namespace "easy" do
  desc "Update Media Library"
  task(:update_library => :environment) do
    require 'yaml'
    require 'find'
    require 'id3lib'
    
    config = YAML.load(File.open("#{RAILS_ROOT}/config/easy.yml"))
    @base_dir = config['music_dir']
    @extnames = [".mp3", ".ogg", ".wav", ".wma"]
    Find.find(@base_dir) do |path|
      if @extnames.include?(File.extname(path))
        print "Processing #{path}... "
        track = Track.find_by_path(path)
        if track.blank? || (track && track.updated_at < File.mtime(path))
          track ||= Track.new(:path => path)
          tag = ID3Lib::Tag.new(path)
          track.set_attributes_from_tag(tag)
          track.save
          puts "Updated!"
        else
          puts "No update required!"
        end
      end 
    end
  end
  
  desc "Remove Dead Tracks"
  task(:remove_dead_tracks => :environment) do
    Track.all.each do |track|
      unless File.exist?(track.path)
        puts "#{track.path} not found.  Deleting from library."
        track.destroy
      end
    end
    
    [Album, Artist].each do |klass|
      klass.all.each { |obj| obj.destroy if obj.tracks.length < 1 }
    end
        
  end
  
  desc "Wipe The Entire Library"
  task(:wipe_library => :environment) do
    Artist.destroy_all
    Track.destroy_all
    Album.destroy_all
  end
end