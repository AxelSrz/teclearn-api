class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.belongs_to :professor, index: true
      t.string :name
      t.string :access_code

      t.timestamps
    end
  end
end
