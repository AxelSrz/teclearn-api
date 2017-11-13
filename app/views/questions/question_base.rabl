attributes :id, :incorrectAnswers
attributes question_description: :question, option_1: :correctAnswer

child :tags, object_root: false do
  attributes :id, :name
end
