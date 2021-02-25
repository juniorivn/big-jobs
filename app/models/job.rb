class Job < ApplicationRecord
  validates :title, :description, :level, :deadline, :salary, :requirements, :total, presence: true 
end
