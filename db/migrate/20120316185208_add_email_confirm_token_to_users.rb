class AddEmailConfirmTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_confirm_token, :string

    add_column :users, :email_confirmed, :boolean, :default => '0'

  end
end
