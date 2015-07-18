class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :name
      t.integer :position

      t.timestamps null: false
    end
  end
end
