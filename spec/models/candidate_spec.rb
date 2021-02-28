require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:cell_phone) }
    it { should validate_presence_of(:short_biography) }
    it { should validate_presence_of(:academic_training) }

  end
end
