class Category < ActiveRecord::Base
  validates :name, presence: true

  has_ancestry
  has_many :items
end
