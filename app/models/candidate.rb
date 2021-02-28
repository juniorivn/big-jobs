class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, :cpf, :cell_phone, :short_biography, :academic_training, presence: true 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

end
