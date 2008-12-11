class RenameLengthToDuration < ActiveRecord::Migration
  def self.up
    rename_column :tracks, :length, :duration
  end

  def self.down
    rename_column :tracks, :duration, :length
  end
end
