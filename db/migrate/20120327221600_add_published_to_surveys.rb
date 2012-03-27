class AddPublishedToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :published, :boolean, :default => 0

  end
end
