class RemoveCorrectFromQuizzes < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :correct_option
  end
end
