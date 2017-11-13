class ModifyAttemptAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :attempt_answers, :answer, :string
    add_column :attempt_answers, :is_correct, :boolean
  end
end
