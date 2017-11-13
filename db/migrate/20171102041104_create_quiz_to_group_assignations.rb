class CreateQuizToGroupAssignations < ActiveRecord::Migration[5.1]
  def change
    create_table :quiz_to_group_assignations do |t|
      t.belongs_to :quiz, index: true
      t.belongs_to :group, index: true
      
      t.timestamps
    end
  end
end
