class DatesToQuizzes < ActiveRecord::Migration[5.1]
  def change
    add_column :quiz_to_group_assignations, :expires_at, :date
  end
end
