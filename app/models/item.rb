class Item < ActiveRecord::Base
  belongs_to :category
  has_many :photos, dependent: :destroy

  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :name, presence: true

  # def photo_ids=(ids)
  #   Photo.where(id: ids).each do |photo|
  #     photo.update_attributes(item_id: self.id)
  #   end
  # end
end
