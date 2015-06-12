class Photo < ActiveRecord::Base
  belongs_to :item
  mount_uploader :image, PhotoUploader
  validates :item_id, presence: true
end
