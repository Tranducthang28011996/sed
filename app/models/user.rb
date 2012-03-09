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
  validates :password,  :length => { :within => 6..40 },
                        :on => :create
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create

  #SPEC: 2.1.2: Default ordering A-Za-z
  default_scope order('users.name ASC')

  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
end

