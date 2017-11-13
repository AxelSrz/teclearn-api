class AttemptAnswer < ApplicationRecord
  belongs_to :attempt
  belongs_to :question

  before_save :check_correct

  def check_correct
    self.is_correct = self.question.option_1 == self.answer
  end
end
