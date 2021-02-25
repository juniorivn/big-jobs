class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.decimal :salary
      t.string :level
      t.string :requirements
      t.date :deadline
      t.integer :total

      t.timestamps
    end
  end
end
