class AddToDeletedToBreeds < ActiveRecord::Migration
  def change
    add_column :breeds, :to_deleted, :boolean, default: false
  end
end
