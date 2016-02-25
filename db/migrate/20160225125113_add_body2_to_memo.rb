class AddBody2ToMemo < ActiveRecord::Migration
  def change
    add_column :memos, :body2, :text
  end
end
