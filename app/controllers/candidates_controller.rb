class CandidatesController < ApplicationController
  before_action :authenticate_candidate!, only: [:index, :edit]
  before_action :authenticate_collaborator!, only: [:show]

  def index
    @candidate = Candidate.find_by(id: current_candidate)
  end

  def show
    @candidate = Candidate.find_by(id: params[:id])
    @candidate_job = CandidateJob.find_by(candidate_id: params[:id], job_id: params[:job_id])
  end 

  def edit
    @candidate = Candidate.find(params[:id])
  end

  def update
    @candidate = Candidate.find(params[:id])
    
    if @candidate.update(candidate_params)
      render :index
    else
      render :edit
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:email, :password, :name, :cell_phone, :cpf,
                                      :short_biography, :academic_training)
  end
end
