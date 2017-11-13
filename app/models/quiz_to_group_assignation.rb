class QuizToGroupAssignation < ApplicationRecord
  belongs_to :quiz
  belongs_to :group

  scope :active, -> {where('expires_at > ?', Date.yesterday)}
  scope :expired, -> {where('expires_at < ?', Date.today)}

  def expiresAt
    self.expires_at.to_time.to_i
  end

  def highest_grades
    Attempt.select('DISTINCT ON (student_id) *').where('quiz_id = ? AND group_id = ?', self.quiz_id, self.group_id).order(:student_id, grade: :desc)
  end

  def recent_grades
    Attempt.select('DISTINCT ON (student_id) *').where('quiz_id = ? AND group_id = ?', self.quiz_id, self.group_id).order(:student_id, created_at: :desc)
  end

  def student_highest_grades(student_id)
    Attempt.where('quiz_id = ? AND group_id = ? AND student_id = ?', self.quiz_id, self.group_id, student_id).order(grade: :desc).first
  end

  def student_recent_grades(student_id)
    Attempt.where('quiz_id = ? AND group_id = ? AND student_id = ?', self.quiz_id, self.group_id, student_id).order(created_at: :desc).first
  end
end
