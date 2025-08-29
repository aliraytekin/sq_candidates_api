class Job < ApplicationRecord
  belongs_to :recruiter
  validates :title, :category, :employment_type, :location, :posted_at, presence: true

  enum :status, { draft: 0, published: 1, archived: 2 }
end
