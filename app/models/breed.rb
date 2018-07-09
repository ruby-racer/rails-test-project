class Breed < ActiveRecord::Base
  validates_presence_of :name, :pic_url
  scope :active, -> { where(to_deleted: false) }
end
