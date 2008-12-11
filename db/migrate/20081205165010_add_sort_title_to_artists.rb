class AddSortTitleToArtists < ActiveRecord::Migration
  def self.up
    remove_column :tracks, :sort_title
    add_column :artists, :sort_title, :string
  end

  def self.down
    remove_column :artists, :sort_title
    add_column :tracks, :sort_title, :string
  end
end
