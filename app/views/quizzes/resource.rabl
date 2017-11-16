object @quiz
attribute :id

glue :quiz do
  attribute :name
  attributes resource_type: :resourceType, resource_url: :resource
end
