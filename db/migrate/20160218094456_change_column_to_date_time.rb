class ChangeColumnToDateTime < ActiveRecord::Migration

  def self.up
    change_table :tasks do |t|
      t.change :dur, :datetime
    end
  end
  def self.down
    change_table :tasks do |t|
      t.change :dur, :float
    end
  end
end
