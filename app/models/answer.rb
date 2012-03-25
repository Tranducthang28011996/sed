# == Schema Information
#
# Table name: answers
#
#  id          :integer(4)      not null, primary key
#  question_id :integer(4)
#  content     :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Answer < ActiveRecord::Base
  attr_accessible :content
  belongs_to :question
  has_many :responses, :dependent => :destroy
  validates_presence_of :content
end
