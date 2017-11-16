class AddOnUseId < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :on_use_identifier, :integer
  end
end
