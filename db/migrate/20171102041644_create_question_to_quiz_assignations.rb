class CreateQuestionToQuizAssignations < ActiveRecord::Migration[5.1]
  def change
    create_table :question_to_quiz_assignations do |t|
      t.belongs_to :question, index: true
      t.belongs_to :quiz, index: true

      t.timestamps
    end
  end
end
