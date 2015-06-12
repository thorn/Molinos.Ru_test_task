class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.boolean :editable, default: true

      t.timestamps null: false
    end
  end
end
