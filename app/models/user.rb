# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  password_digest        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  email_confirm_token    :string(255)
#  email_confirmed        :boolean(1)      default(FALSE)
#  roles_mask             :integer(4)      default(1)
#

class User < ActiveRecord::Base
  #SPEC: 1.1.1: Username(email)
  #SPEC: 1.1.2: Password
  has_secure_password
  attr_accessible :name, :email, :password, :password_confirmation, :email_confirmed, :roles
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  validates :password,  :length => { :within => 6..40 },
                        :on => :create
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create

  # Relations
  has_many :responses, :dependent => :destroy
  accepts_nested_attributes_for :responses

  #ROLES
  ROLES = %w[student advisor professor god]
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }
  scope :students, lambda { with_role("student") }
  scope :advisors, lambda { with_role("advisor") }
  scope :professors, lambda { with_role("professor") }
  scope :gods, lambda { with_role("god") }
  scope :with_name, lambda { |term| where("users.name LIKE ?", "%#{term}%") }

  #default_scope order('users.name ASC')

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

  #SPEC: 1.1.3.3: Email Confirmation
  def send_email_confirm
    generate_token(:email_confirm_token)
    save!
    UserMailer.email_confirm(self).deliver
  end

  #Roles
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role_symbols
    roles.map(&:to_sym)
  end

  def role?(role)
    roles.include? role.to_s
  end

  # they can only search for students
  def self.search(search, page = nil)
    if search
      students.with_name(search).paginate(:page => page, :per_page => 15)
    else
      students.paginate(:page => page)
    end
  end
end

