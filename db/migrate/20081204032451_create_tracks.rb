class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :path
      t.string :title
      t.integer :artist_id
      t.integer :album_id
      t.string :track_number
      t.integer :length
      t.integer :year

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
