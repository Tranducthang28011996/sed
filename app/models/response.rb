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
  has_one :question, :through => :answer

  # A user can only have one response per question per survey
  # (something of the form validates_uniquness of
  # http://ar.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html#M000086
  validates_uniqueness_of :question_id, :scope => [:user_id], :message => "You have already answered that question!"

  scope :anonymous, lambda { joins(:question).where("anonymous = true") }
  scope :not_anonymous, lambda { joins(:question).where("anonymous = false") }

  private
  def self.who_answered_me(answer_id_in)
    Response.where(:answer_id => answer_id_in).map(&:user).map(&:name)
  end

  def self.answers_total_count(answer_id_in)
    where(:answer_id => answer_id_in).count
  end
end
