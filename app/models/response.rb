# == Schema Information
#
# Table name: responses
#
#  id          :integer(4)      not null, primary key
#  answer_id   :integer(4)
#  user_id     :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  content     :text
#  question_id :integer(4)
#

class Response < ActiveRecord::Base
  #SPEC: 5.5 Reponse Model
  #SPEC 5.5.1 Add attributes
  #SPEC 5.5.1.1 Answer ID's
  #SPEC 5.5.1.2 User ID's
  belongs_to :answer
  belongs_to :user

  # A user can only have one response per question per survey
  # (something of the form validates_uniquness of
  # http://ar.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html#M000086
  validates_uniqueness_of :question_id, :scope => [:user_id], :message => "You have already answered that question!"
end
