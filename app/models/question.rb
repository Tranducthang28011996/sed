# == Schema Information
#
# Table name: questions
#
#  id         :integer(4)      not null, primary key
#  survey_id  :integer(4)
#  content    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Question < ActiveRecord::Base
  attr_accessible :content, :answers_attributes

  belongs_to :survey
  has_many :answers, :dependent => :destroy

  #SPEC: 5.3.1.1: Content
  accepts_nested_attributes_for :answers,
        :reject_if => lambda { |a| a[:content].blank? },
        :allow_destroy => true

  validates_presence_of :answers
  validates_presence_of :content

  scope :by_survey, lambda { |survey| where("survey_id = ?", survey) }

  def my_questions
    Question.by_survey(self.survey_id).map(&:id)
  end
end
