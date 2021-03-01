class Company < ApplicationRecord
  has_one_attached :photo
  has_many :collaborators
  has_many :jobs
end
