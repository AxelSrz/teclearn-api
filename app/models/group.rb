class Group < ApplicationRecord
  belongs_to :professor
  has_many :quiz_to_group_assignations
  has_many :quizzes, through: :quiz_to_group_assignations

  has_many :student_to_group_assignations
  has_many :students, through: :student_to_group_assignations

  has_many :active_assignations, -> {where('expires_at > ?', Date.yesterday)}, class_name: "QuizToGroupAssignation"
  has_many :active_quizzes, through: :active_assignations, source: :quiz

  has_many :expired_assignations, -> {where('expires_at < ?', Date.today)}, class_name: "QuizToGroupAssignation"
  has_many :expired_quizzes, through: :expired_assignations, source: :quiz

  before_save :generate_access_code

  def generate_access_code
    if self.access_code.nil?
      self.access_code = SecureRandom.base58(8)
    end
  end

  def number_of_active_quizzes
    self.active_quizzes.count
  end

  def active_assignations
    self.quiz_to_group_assignations.merge(QuizToGroupAssignation.active).includes(:quiz)
  end

  def expired_assignations
    self.quiz_to_group_assignations.merge(QuizToGroupAssignation.expired).includes(:quiz)
  end

  def quizzes_ids
    self.quizzes.collect{ |q| q.id}
  end

  def highestGrades
    res = []
    self.students.each do |s|
      h = {id: s.id, student: s.name}
      hg = s.get_highest_grades(self.id, self.quizzes_ids)
      h[:grades] = hg
      h[:average] = hg.size != 0 ? hg.inject(0.0) { |sum, el| sum + el } / hg.size : 0
      res.push(h)
    end
    res
  end

  def recentGrades
    res = []
    self.students.each do |s|
      h = {id: s.id, student: s.name}
      hg = s.get_recent_grades(self.id, self.quizzes_ids)
      h[:grades] = hg
      h[:average] = hg.size != 0 ? hg.inject(0.0) { |sum, el| sum + el } / hg.size : 0
      res.push(h)
    end
    res
  end

end
