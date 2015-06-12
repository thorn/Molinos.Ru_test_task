class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image
      t.boolean :main, default: false
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
