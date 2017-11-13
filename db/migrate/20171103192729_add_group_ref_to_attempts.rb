class AddGroupRefToAttempts < ActiveRecord::Migration[5.1]
  def change
    add_reference :attempts, :group, foreign_key: true
  end
end
