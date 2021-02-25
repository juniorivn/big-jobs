class AddRoleToCollaborator < ActiveRecord::Migration[6.1]
  def change
    add_column :collaborators, :role, :integer, default: 0, null: false
  end
end
