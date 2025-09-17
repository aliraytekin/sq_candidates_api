class AddSalaryRangeToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :min_salary, :integer
    add_column :jobs, :max_salary, :integer
  end
end
