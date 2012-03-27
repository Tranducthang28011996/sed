class AddQuestionReferenceToResponse < ActiveRecord::Migration
  def change
    change_table :responses do |t|
      t.references :question
    end
    add_index :responses, :question_id
  end
end
