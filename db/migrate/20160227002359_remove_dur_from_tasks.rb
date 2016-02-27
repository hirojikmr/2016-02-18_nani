class RemoveDurFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :dur, :datetime
  end
end
