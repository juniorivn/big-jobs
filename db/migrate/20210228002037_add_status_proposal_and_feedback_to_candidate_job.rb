class AddStatusProposalAndFeedbackToCandidateJob < ActiveRecord::Migration[6.1]
  def change
    add_column :candidate_jobs, :status_proposal, :integer, default: 0, null: false
    add_column :candidate_jobs, :feedback, :text
  end
end
