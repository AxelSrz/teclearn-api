class Tag < ApplicationRecord
  belongs_to :professor
  has_many :tag_to_question_assignations
  has_many :questions, through: :tag_to_question_assignations
end
