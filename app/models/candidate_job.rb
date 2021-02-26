class CandidateJob < ApplicationRecord
  belongs_to :candidate
  belongs_to :job

  enum status_candidate: {pending: 0, disapproved: 5, approved: 10 }
end
