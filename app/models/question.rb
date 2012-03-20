class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, :dependent => :destroy

  #SPEC: 5.3.1.1: Content
  validates_presence_of :content
  accepts_nested_attributes_for :answers,
        :reject_if => lambda { |a| a[:content].blank? },
        :allow_destroy => true
end
