class Question < ApplicationRecord
  has_many :attempt_answers
  has_many :attempts, through: :attempt_answers
  has_many :question_to_quiz_assignations
  has_many :quizzes, through: :question_to_quiz_assignations
  has_many :tag_to_question_assignations
  has_many :tags, through: :tag_to_question_assignations

  def createdAt
    self.created_at.to_time.to_i
  end

  def incorrectAnswers
      incorrect = []
      incorrect.push(self.option_2)
      incorrect.push(self.option_3) unless option_3.nil?
      incorrect.push(self.option_4) unless option_4.nil?
      incorrect.push(self.option_5) unless option_5.nil?
      incorrect
  end

  def tags_ids
    self.tags.collect{ |tag| tag.id }
  end

  def randomize_answers
    a = incorrectAnswers
    a.push(self.option_1)
    a.shuffle
  end
end
