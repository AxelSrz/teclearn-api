class CreateQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :quizzes do |t|
      t.belongs_to :professor, index: true
      t.string :resource_url
      
      t.timestamps
    end
  end
end
