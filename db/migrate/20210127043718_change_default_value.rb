class ChangeDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :can_edit, false
  end
end
