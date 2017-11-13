attributes :id, :name, :createdAt
attributes resource_type: :resourceType, resource_url: :resource

child :questions, object_root: false do
  attributes :id, :incorrectAnswers
  attributes question_description: :question, option_1: :correctAnswer
end
