class AlterCnpjToCompany < ActiveRecord::Migration[6.1]
  def up
    change_table :companies do |t|
      t.change :cnpj, :string
    end
  end

  def down
    change_table :companies do |t|
      t.change :cnpj, :integer
    end
  end
end
