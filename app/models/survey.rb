# == Schema Information
#
# Table name: surveys
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  published    :boolean(1)      default(FALSE)
#  available_at :datetime
#  anonymous    :boolean(1)      default(FALSE)
#

class Survey < ActiveRecord::Base
  after_save :check_anonymous
  attr_accessible :name, :published, :available_at, :questions_attributes, :anonymous
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions,
        :reject_if => lambda { |q| q[:content].blank? },
        :allow_destroy => true
  validates_presence_of :name
  validates_presence_of :questions

  # scopes for published or drafts
  scope :published , where("surveys.published IS NOT false")
  scope :draft , where("surveys.published IS false")
  scope :available, lambda { published.where("surveys.available_at < ?", Time.now.in_time_zone("Mountain Time (US & Canada)") ) }

  # return an array of all my questions
  def my_questions
    self.questions.map(&:id)
  end

  def my_anonymous_questions
    questions.where(:anonymous => true)
  end

  def my_public_questions
    questions.where(:anonymous => false)
  end

  def check_anonymous
    if anonymous == true
      questions.each { |question| question.update_attributes(:anonymous => true) }
    else
      questions.each { |question| question.update_attributes(:anonymous => false) }
    end
  end
end
