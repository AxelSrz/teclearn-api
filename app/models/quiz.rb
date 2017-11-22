class Quiz < ApplicationRecord
  has_many :attempts
  has_many :students, through: :attempts
  has_many :question_to_quiz_assignations
  has_many :questions, through: :question_to_quiz_assignations
  has_many :quiz_to_group_assignations
  has_many :groups, through: :quiz_to_group_assignations

  def createdAt
    self.created_at.to_time.to_i * 1000
  end

  def number_of_completed(group_identifier)
    self.attempts.where(group_id: group_identifier).select(:student_id).distinct.count
  end

  def questions_ids
    self.questions.collect{ |qq| qq.id }
  end
end
