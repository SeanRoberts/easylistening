namespace "easy" do
  desc "Update Media Library"
  task(:update_library => :environment) do
    require 'find'
    require 'id3lib'
    @base_dir = "/Users/seanroberts/Music"
    @extnames = [".mp3", ".ogg", ".wav", ".wma"]
    Find.find(@base_dir) do |path|
      if @extnames.include?(File.extname(path))
        unless Track.find_by_path(path)
          puts "Processing #{path}..."
          track, tag = Track.new(:path => path), ID3Lib::Tag.new(path)
          track.get_info_from_tag!(tag)
          track.save
        end
      end 
    end
  end
  
  desc "Wipe The Entire Library"
  task(:wipe_library => :environment) do
    Artist.destroy_all
    Track.destroy_all
    Album.destroy_all
  end
end