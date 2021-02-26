module JobsHelper

  def search_candidate_job?(candidate_id, job_id)
    byebug
    CandidateJob.find_by(candidate_id: candidate_id, job_id: job_id).blank?
  end
end