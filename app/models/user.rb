class User < ActiveRecord::Base
  #SPEC: 1.1.1: Username(email)
  #SPEC: 1.1.2: Password
  has_secure_password
  attr_accessible :name, :email, :password, :password_confirmation
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  validates :password,  :confirmation => true,
                        :length => { :within => 6..40 },
                        :on => :create
  validates_presence_of :password, :on => :create
end

