class Student < ApplicationRecord
  has_many :attempts
  has_many :quizzes, through: :attempts
  has_many :student_to_group_assignations
  has_many :groups, through: :student_to_group_assignations

  attribute :password, :string

  before_save :encrypt_password, :check_state

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    student = find_by_email(email)
    if student && student.password_hash == BCrypt::Engine.hash_secret(password, student.password_salt)
      student
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

  def check_state
    if self.state.nil?
      self.state = "free"
    end
  end

  def get_highest_grades(group_id, quizzes_ids)
    res = []
    quizzes_ids.each do |quiz_id|
      a = Attempt.where('student_id =? AND quiz_id = ? AND group_id = ?', self.id, quiz_id, group_id).order(grade: :desc)
      a = a.empty? ? -1 : a.first.grade
      res.push(a)
    end
    res
  end

  def get_recent_grades(group_id, quizzes_ids)
    res = []
    quizzes_ids.each do |quiz_id|
      a = Attempt.where('student_id =? AND quiz_id = ? AND group_id = ?', self.id, quiz_id, group_id).order(created_at: :desc)
      a = a.empty? ? -1 : a.first.grade
      res.push(a)
    end
    res
  end

  def get_group_overview(group_id)
    g = self.groups.find(group_id)
    h = nil
    unless g.nil?
      h = {id: g.id, average: 0, currentExams: [], pastExams: []}
      valid_grades = []
      g.active_assignations.each do |assignation|
        h_aux = {id: assignation.id, name: assignation.quiz.name, exipresAt: assignation.expiresAt}
        hg = assignation.student_highest_grades(self.id)
        rg = assignation.student_recent_grades(self.id)
        unless hg.nil?
          h_aux[:highestGrade] = hg.grade
          h_aux[:recentGrade] = rg.grade
          valid_grades.push(rg.grade)
        end
        h[:currentExams].push(h_aux)
      end
      g.expired_assignations.each do |assignation|
        h_aux = {id: assignation.id, name: assignation.quiz.name, exipresAt: assignation.expiresAt}
        hg = assignation.student_highest_grades(self.id)
        rg = assignation.student_recent_grades(self.id)
        unless hg.nil?
          h_aux[:highestGrade] = hg.grade
          h_aux[:recentGrade] = rg.grade
          valid_grades.push(rg.grade)
        end
        h[:pastExams].push(h_aux)
      end

      h[:average] = valid_grades.size != 0 ? valid_grades.inject(0.0) { |sum, el| sum + el } / valid_grades.size : 0
    end
    OpenStruct.new(h)
  end

end
