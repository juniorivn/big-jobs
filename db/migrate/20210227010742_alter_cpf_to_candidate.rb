class AlterCpfToCandidate < ActiveRecord::Migration[6.1]
  def up
    change_table :candidates do |t|
      t.change :cpf, :string
    end
  end

  def down
    change_table :candidates do |t|
      t.change :cpf, :integer
    end
  end
end
