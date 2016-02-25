class AddBodyToMemo < ActiveRecord::Migration
  def change
    add_column :memos, :body3, :text
  end
end
