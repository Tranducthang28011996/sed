class AddAvailableAtToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :available_at, :datetime

  end
end
