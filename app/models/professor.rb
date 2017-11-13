class Professor < ApplicationRecord
  has_many :groups
  has_many :questions
  has_many :quizzes
  has_many :tags

  attribute :password, :string

  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    professor = find_by_email(email)
    if professor && professor.password_hash == BCrypt::Engine.hash_secret(password, professor.password_salt)
      professor
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
