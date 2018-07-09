class AddToDeletedToBreeds < ActiveRecord::Migration
  def change
    add_column :breeds, :to_delete, :boolean, default: false
  end
end
