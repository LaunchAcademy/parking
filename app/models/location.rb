class Location < ActiveRecord::Base
  validates_uniqueness_of :name, allow_blanks: false
end
