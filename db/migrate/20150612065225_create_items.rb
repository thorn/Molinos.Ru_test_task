class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.references :category, index: true, foreign_key: true
      t.decimal :price, :precision => 8, :scale => 2, default: 0

      t.timestamps null: false
    end
  end
end
