object @quiz
attribute :id

glue :quiz do
  attribute :name

  child :questions, object_root: false do
    attribute :id
    attributes question_description: :question, randomize_answers: :answers
  end
end
