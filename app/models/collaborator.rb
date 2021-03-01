class Collaborator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :cpf, presence: true 
  has_one :candidate_job
  has_many :jobs
  enum role: { user: 0, admin: 5}
  before_save :admin_company

  private

  def admin_company 
    company_url = self.email.split('@').last
    company_found = Company.find_by(domain: company_url)
    if company_found.blank?
      self.role = 5
      Company.create!(domain: company_url)
    end
    self.company_id = Company.find_by(domain: company_url).id

  end
end
