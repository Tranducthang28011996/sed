# == Schema Information
#
# Table name: responses
#
#  id         :integer(4)      not null, primary key
#  answer_id  :integer(4)
#  user_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  content    :text
#

class Response < ActiveRecord::Base
  #SPEC: 5.5 Reponse Model
  #SPEC 5.5.1 Add attributes
  #SPEC 5.5.1.1 Answer ID's
  #SPEC 5.5.1.2 User ID's
  belongs_to :answer
  belongs_to :user

  # A user can only have one response per question per survey
  validate :has_unique_repsonse
  validate :has_one_answer_per_question

  private

  def has_unique_repsonse
    if (Response::find_all_by_answer_id_and_user_id( answer.id, user.id ).count > 0)
      errors.add(:response, "You cannot answer the same question with the same answer!")
    end
  end

  def has_one_answer_per_question
    if (user.responses.joins(:answer).group(:question_id).where( :id => id ).count.first.try(:last) || 0 > 0)
      errors.add(:response, "You cannot answer the same question with the multiple answers!")
    end
  end
end
