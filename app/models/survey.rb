# == Schema Information
#
# Table name: surveys
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Survey < ActiveRecord::Base
  attr_accessible :name, :questions_attributes
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions,
        :reject_if => lambda { |q| q[:content].blank? },
        :allow_destroy => true
  validates_presence_of :name
  validates_presence_of :questions
end
