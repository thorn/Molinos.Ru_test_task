class Photo < ActiveRecord::Base
  belongs_to :item
  mount_uploader :image, PhotoUploader
  validates :image, presence: true
end
