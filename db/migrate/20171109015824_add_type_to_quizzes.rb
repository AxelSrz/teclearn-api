class AddTypeToQuizzes < ActiveRecord::Migration[5.1]
  def change
    add_column :quizzes, :resource_type, :string
  end
end
