class Track < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album
  
  def set_attributes_from_tag(tag)
    # Artist and Album
    self.artist = Artist.find_by_title(tag.artist.gsub(/\000/, '')) || Artist.create(:title => tag.artist.gsub(/\000/, '')) unless tag.artist.blank?
    self.album = Album.find_by_title(tag.album.gsub(/\000/, '')) || Album.create(:title => tag.album.gsub(/\000/, '')) unless tag.album.blank?
    
    # Title
    self.title = tag.title ? tag.title.gsub(/\000/, '') : File.basename(path)
        
    # Track and Sorting Track Tracks are strings sometimes formatted as "5/14", 
    # sort_track is an integer field so that would just be saved as 5
    self.sort_track_number = self.track_number = tag.track.gsub(/\000/, '') unless tag.track.blank?
    
    # Track Length, Track Year
    song_duration = tag.select { |hash| hash[:id] == :TLEN }
    self.duration = song_duration[0][:text].gsub(/\000/, '') unless song_duration.blank? || song_duration[0][:text].blank?
    self.year = tag.year.gsub(/\000/, '') unless tag.year.blank?
  end

  def launch_path
	  path.gsub('/cygdrive/d', 'D:').gsub('/', '\\')
  end
      
end
