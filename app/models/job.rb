class Job < ApplicationRecord
  belongs_to :recruiter
  validates :title, :category, :employment_type, :location, presence: true

  enum :status, { draft: 0, published: 1, archived: 2 }

  searchkick word_start: %i[title category location employment_type min_experience max_experience min_salary max_salary]

  def search_data
    {
      title: title,
      category: category,
      location: location,
      employment_type: employment_type,
      min_experience: min_experience,
      max_experience: max_experience,
      min_salary: min_salary,
      max_salary: max_salary,
    }
  end
end
