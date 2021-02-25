require 'rails_helper'

describe Job do
  context 'validation' do
    it 'attributes connet be blank' do
      job = Job.new

      expect(job.valid?).to eq false
      expect(job.errors.count).to eq 7

    end
  end
end
