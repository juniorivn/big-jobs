class CompaniesController < ApplicationController
  
  before_action :authenticate_collaborator!, only: [:edit, :show]

  def index
    @companies = Company.all
  end
 
  def show
    @company =  Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company =  Company.find(params[:id])

    if @company.update(company_params)
      redirect_to @company
    else
      render :edit
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :logo, :cnpj, :address,
                                    :district, :city, :state, :zip_code,
                                    :facebook, :instagram, :photo)

  end

end