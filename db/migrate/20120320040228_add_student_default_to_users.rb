class AddStudentDefaultToUsers < ActiveRecord::Migration
  def change
    change_column :users, :roles_mask, :integer, :default => 1
  end
end
