class AddBody5ToMemo < ActiveRecord::Migration
  def change
    add_column :memos, :body5, :text
  end
end
