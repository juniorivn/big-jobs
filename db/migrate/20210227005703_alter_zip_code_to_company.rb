class AlterZipCodeToCompany < ActiveRecord::Migration[6.1]
  def up
    change_table :companies do |t|
      t.change :zip_code, :string
    end
  end

  def down
    change_table :companies do |t|
      t.change :zip_code, :integer
    end
  end
end
