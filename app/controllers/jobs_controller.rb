class JobsController < ApplicationController
  
  before_action :authenticate_collaborator!, only: [:new, :create, :edit]


  def index
    if collaborator_signed_in?
      @jobs = Job.where(company_id: current_collaborator.company_id)
    elsif params[:company_id].present?
      @jobs = Job.where(company_id: params[:company_id])
    else
      @jobs = Job.all
    end
  end

  def new
    @job = Job.new
   
  end

  def create
    @job = Job.new(job_params)
    @job.company_id = current_collaborator.company_id
   
    if @job.save
      redirect_to @job
    else
      render 'new'
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    
    if @job.update(job_params)
      redirect_to @job
    else
      render :edit
    end
  end

  def application
    job = Job.find(params[:id])
    job.application_job(current_candidate.id, job.id)
    redirect_to job

  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :salary,
                                :level, :requirements,
                                :deadline, :total)
  end
end