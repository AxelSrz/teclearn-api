object @quiz_to_group_assignation

glue :quiz do
  child :questions, object_root: false do
    attribute :id
    attribute question_description: :question
  end
end

child :highest_grades, root: 'highestGrades', object_root: false do
  attribute :id, :grade
  glue :student do
    attribute name: :student
  end
  child :attempt_answers, root: 'answers', object_root: false do
    attribute is_correct: :isCorrect
    attribute :answer
  end
end

child :recent_grades, root: 'recentGrades', object_root: false do
  attribute :id, :grade
  glue :student do
    attribute name: :student
  end
  child :attempt_answers, root: 'answers', object_root: false do
    attribute is_correct: :isCorrect
    attribute :answer
  end
end
