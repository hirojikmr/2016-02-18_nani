class CreateCapsels < ActiveRecord::Migration
  def change
    create_table :capsels do |t|
      t.date :start
      t.date :end

      t.timestamps null: false
    end
  end
end
