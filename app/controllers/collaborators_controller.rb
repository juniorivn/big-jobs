class CollaboratorsController < ApplicationController
  before_action :authenticate_collaborator!
  def index
    @company = Company.find(current_collaborator.company_id)
  end

end
