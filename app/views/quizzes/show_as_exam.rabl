object @quiz

attributes :id, :name

child :questions, object_root: false do
  attribute :id
  attributes question_description: :question, randomize_answers: :answers
end
