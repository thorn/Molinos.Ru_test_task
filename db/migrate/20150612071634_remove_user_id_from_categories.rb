class RemoveUserIdFromCategories < ActiveRecord::Migration
  def up
    remove_index :categories, :user_id
    remove_column :categories, :user_id
  end

  def down
    add_column :categories, :user_id, :integer
    add_index :categories, :user_id
  end
end
