class AddSortFieldsToTracks < ActiveRecord::Migration
  def self.up
    add_column :tracks, :sort_title, :string
    add_column :tracks, :sort_track_number, :integer
  end

  def self.down
    remove_column :tracks, :sort_track_number
    remove_column :tracks, :sort_title
  end
end
