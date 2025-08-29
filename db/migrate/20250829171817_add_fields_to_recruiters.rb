class AddFieldsToRecruiters < ActiveRecord::Migration[7.1]
  def change
    add_column :recruiters, :first_name, :string
    add_column :recruiters, :last_name, :string
    add_column :recruiters, :company_name, :string
  end
end
