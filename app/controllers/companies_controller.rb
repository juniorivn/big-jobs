class CompaniesController < ApplicationController
  
  before_action :authenticate_collaborator!, only: [:edit, :show]
  

  def index
    @companies = Company.all
  end
 
  def show
    @company =  Company.find(params[:id])
  end

  def search 
    @companies = Company.where(' name  like ? ', "%#{params[:query]}%")
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company =  Company.find(params[:id])
    if @company.update(company_params)
      @company.include_facebook
      @company.include_instagram
      @company.save
      redirect_to @company
    else
      render :edit
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :logo, :cnpj, :address,
                                    :district, :city, :state, :zip_code,
                                    :facebook, :instagram, :logo)

  end

end