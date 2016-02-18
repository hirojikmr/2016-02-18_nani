class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.datetime :start
      t.datetime :end
      t.time :dur
      t.text :body

      t.timestamps null: false
    end
  end
end
