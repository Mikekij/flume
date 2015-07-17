class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :starttime
      t.datetime :endtime
      t.integer :duration
      t.integer :linac_id
      t.integer :created_by_user_id
      t.text :description

      t.timestamps null: false
    end
  end
end
