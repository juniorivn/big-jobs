class CompaniesController < ApplicationController
  before_action :authenticate_collaborator!

  def index
    @companies = Company.all
    
  end

  def edit
    @company = Company.find(params[:id])
  end

end