class CreateStudentToGroupAssignations < ActiveRecord::Migration[5.1]
  def change
    create_table :student_to_group_assignations do |t|
      t.belongs_to :student, index: true
      t.belongs_to :group, index: true

      t.timestamps
    end
  end
end
