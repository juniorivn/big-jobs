class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # def validator_cpf
  #   cpf = CPF.new(self.cpf)
  #   cpf.valid?
  # end|

end
