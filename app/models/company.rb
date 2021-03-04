class Company < ApplicationRecord
  validate :validade_fields, on: :update
  has_one_attached :logo 
  has_many :collaborators
  has_many :jobs
  
  def validade_fields
    errors.add(:name, "não pode ficar em branco") unless name.present?
    errors.add(:state, "não pode ficar em branco") unless name.present?
    errors.add(:zip_code, "não pode ficar em branco") unless name.present?
    errors.add(:facebook, "não pode ficar em branco") unless name.present?
    errors.add(:instagram, "não pode ficar em branco") unless name.present?
    errors.add(:cnpj, "não pode ficar em branco") unless name.present?
    errors.add(:address, "não pode ficar em branco") unless name.present?
    errors.add(:district, "não pode ficar em branco") unless name.present?
    errors.add(:city, "não pode ficar em branco") unless name.present?

  end

  def include_facebook
    if self.facebook.present?
      url_pattern = "https://www.facebook.com/"
      url = self.facebook.split("facebook.com/")
      self.facebook = url_pattern.concat(url.last)
    end
  

  end

end
