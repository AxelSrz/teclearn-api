class Attempt < ApplicationRecord
  belongs_to :quiz
  belongs_to :student
  belongs_to :group
  has_many :attempt_answers
  has_many :questions, through: :attempt_answers

  def calculate_grade
    number_of_questions = self.attempt_answers.count
    correct_answers = self.attempt_answers.where(is_correct: true).count

    self.grade = (correct_answers / Float(number_of_questions)).round(2) * 100
    self.save!
  end
end
