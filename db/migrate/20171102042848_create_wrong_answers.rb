class CreateWrongAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :wrong_answers do |t|
      t.belongs_to :question, index: true
      t.belongs_to :attempt, index: true
      t.string :selected_answer
      
      t.timestamps
    end
  end
end
