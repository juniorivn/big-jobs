class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :domain
      t.string :logo
      t.integer :cnpj
      t.string :address
      t.string :district
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :facebook
      t.string :instagram

      t.timestamps
    end
  end
end
