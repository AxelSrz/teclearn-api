class DropWrongAnswerss < ActiveRecord::Migration[5.1]
  def change
    drop_table :wrong_answers
    rename_table :correct_answers, :attempt_answers
  end
end
