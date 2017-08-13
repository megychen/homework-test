class AddIndexToOrder < ActiveRecord::Migration[5.0]
  def change
    add_index :orders, :user_id
  end
end
