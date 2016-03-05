class CreateTaskColors < ActiveRecord::Migration
  def change
    create_table :task_colors do |t|
      t.string :text
      t.string :color

      t.timestamps null: false
    end
  end
end
