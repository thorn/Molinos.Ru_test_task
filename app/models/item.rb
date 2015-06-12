class Item < ActiveRecord::Base
  belongs_to :category

  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :name, presence: true
end
