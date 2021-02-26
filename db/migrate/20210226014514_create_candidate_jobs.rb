class CreateCandidateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :candidate_jobs do |t|
      t.integer :status_candidate, default: 0, null: false
      t.references :candidate, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
