class Item < ActiveRecord::Base
  belongs_to :category
  has_many :photos, dependent: :destroy

  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  # russian charachters in slug
  def normalize_friendly_id(string)
    string.to_slug.normalize.to_s
  end

end
