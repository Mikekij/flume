class CreateLinacs < ActiveRecord::Migration
  def change
    create_table :linacs do |t|
      t.string :name
      t.integer :user_group_id

      t.timestamps null: false
    end
  end
end
