require 'rails_helper'

describe Job do
  context 'validation' do
    it 'attributes connet be blank' do
      job = Job.new

      expect(job.valid?).to eq false
      expect(job.errors.count).to eq 8

    end
  end
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:salary) }
    it { should validate_presence_of(:level) }
    it { should validate_presence_of(:deadline) }
    it { should validate_presence_of(:total) }

  end
end
