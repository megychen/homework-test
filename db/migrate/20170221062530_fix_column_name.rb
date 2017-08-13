class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :assm_state, :aasm_state
    rename_index :orders, :assm_state, :aasm_state
  end
end
