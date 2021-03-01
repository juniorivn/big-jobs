class CandidateJobsController < ApplicationController
  def edit
    @candidate_job = CandidateJob.find(params[:id])
  end

  def update
    @candidate_job = CandidateJob.find(params[:id])
    
    if @candidate_job.update(candidate_job_params)
      @candidate =  @candidate_job.candidate
      if current_collaborator.present?
        redirect_to candidate_path(@candidate, job_id: @candidate_job.job_id)
      else
        redirect_to job_path(@candidate, job_id: @candidate_job.job_id)
      end
    else
      render :edit
    end
  end

  private

  def candidate_job_params
    params.require(:candidate_job).permit(:feedback)
  end
end
