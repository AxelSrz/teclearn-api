class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.belongs_to :professor, index: true
      t.string :name
      
      t.timestamps
    end
  end
end
