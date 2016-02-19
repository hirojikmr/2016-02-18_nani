class ChangeDateTimeToDate < ActiveRecord::Migration
  def self.up
    change_table :memos do |t|
      t.change :date, :date
    end
  end
  def self.down
    change_table :products do |t|
      t.change :date, :datetime
    end
  end
end

