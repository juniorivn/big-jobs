class Job < ApplicationRecord
  validates :title, :description, :level, :deadline, :salary, :requirements, :total, presence: true 
  belongs_to :company
  enum status: {enabled: 0, disabled: 5}

  def application_job(candidate_id, job_id)
    CandidateJob.create(status_candidate: 0, candidate_id: candidate_id, job_id: job_id)
  end

  def candidacies
    CandidateJob.where(job_id: self.id)
  end

end
