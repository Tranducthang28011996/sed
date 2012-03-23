class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :responses, :dependent => :destroy
end
