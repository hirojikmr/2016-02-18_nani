class AddShowFlgToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :show_flg, :boolean, default: true
  end
end
