class Artist < ActiveRecord::Base
  has_many :tracks
  has_many :albums, :through => :tracks
  
  before_save :set_sort_title
  
  private
    def set_sort_title
      # "The Beatles" => "Beatles", "A Tribe Called Quest" => "Tribe Called Quest"
      prefix = /^The |^the |^[Aa]/
      sort_title = title.match(prefix) ? title.gsub(prefix, '') : title
    end
end
