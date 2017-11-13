class CreateTagToQuestionAssignations < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_to_question_assignations do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :question, index: true

      t.timestamps
    end
  end
end
