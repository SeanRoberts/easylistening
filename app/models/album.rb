class Album < ActiveRecord::Base
  has_many :tracks, :order => "sort_track_number"
end
