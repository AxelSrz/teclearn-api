class AddStateToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :state, :string
  end
end
