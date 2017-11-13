class CreateCorrectAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :correct_answers do |t|
      t.belongs_to :question, index: true
      t.belongs_to :attempt, index: true

      t.timestamps
    end
  end
end
