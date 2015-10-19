class CreateWhiteLists < ActiveRecord::Migration
  def change
    create_table :white_lists do |t|
      t.string :email, null: false
      t.boolean :active, null: false, default: true

      t.timestamps null: false
    end
  end
end
