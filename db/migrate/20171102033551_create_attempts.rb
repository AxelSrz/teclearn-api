class CreateAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :attempts do |t|
      t.belongs_to :student, index: true
      t.belongs_to :quiz, index: true
      t.float :grade

      t.timestamps
    end
  end
end
