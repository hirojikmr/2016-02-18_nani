class AddBody4ToMemo < ActiveRecord::Migration
  def change
    add_column :memos, :body4, :text
  end
end
