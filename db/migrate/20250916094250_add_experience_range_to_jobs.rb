class AddExperienceRangeToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :min_experience, :integer
    add_column :jobs, :max_experience, :integer
  end
end
