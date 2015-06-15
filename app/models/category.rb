class Category < ActiveRecord::Base
  validates :name, presence: true

  has_ancestry orphan_strategy: :rootify
  has_many :items
end
