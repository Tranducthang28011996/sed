class Response < ActiveRecord::Base
  #SPEC: 5.5 Reponse Model
  #SPEC 5.5.1 Add attributes
  #SPEC 5.5.1.1 Answer ID's
  #SPEC 5.5.1.2 User ID's
  belongs_to :answer
  belongs_to :user
end
