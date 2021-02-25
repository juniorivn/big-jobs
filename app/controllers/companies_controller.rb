class CompaniesController < ApplicationController
  before_action :authenticate_collaborator!

  def index
  end

end