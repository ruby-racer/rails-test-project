class Breed < ActiveRecord::Base
  validates_presence_of :name, :pic_url

  scope :active, -> { where(to_delete: false) }

  def friendly_name
    name.split('/').reverse.map(&:classify).join(' ')
  end
end
