class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :professors, :password, :password_hash
    add_column :professors, :password_salt, :string
    rename_column :students, :password, :password_hash
    add_column :students, :password_salt, :string
  end
end
