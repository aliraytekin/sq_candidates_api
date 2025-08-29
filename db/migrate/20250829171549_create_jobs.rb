class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.references :recruiter, null: false, foreign_key: true
      t.string :title
      t.string :category
      t.string :employment_type
      t.string :location
      t.date :posted_at
      t.integer :status

      t.timestamps
    end
  end
end
