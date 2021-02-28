class CollaboratorsController < ApplicationController
  before_action :authenticate_collaborator!
  def index
    @collaborator = Collaborator.find(current_collaborator.id)
    @company = Company.find(current_collaborator.company_id)
  end

end
