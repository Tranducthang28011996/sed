class AddAllowFreeResponseToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :allow_free_response, :boolean, :default => false

  end
end
