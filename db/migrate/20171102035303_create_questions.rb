class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.belongs_to :professor, index: true
      t.string :question_description
      t.integer :correct_option
      t.string :option_1
      t.string :option_2
      t.string :option_3
      t.string :option_4
      t.string :option_5

      t.timestamps
    end
  end
end
