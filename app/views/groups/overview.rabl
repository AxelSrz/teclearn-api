object @group

attributes :id, :name
attributes access_code: :groupCode

# REFACTORING - los siguientes childs de quiz assignations pueden hacer template

child :active_assignations, root: 'currentExams', object_root: false do |assignation|
  attribute :expiresAt

  glue :quiz do |q|
    attributes :id, :name
    node(:completed) { q.number_of_completed(@group.id) }
  end

end

child :expired_assignations, root: 'pastExams', object_root: false do |assignation|
  attribute :expiresAt

  glue :quiz do |q|
    attributes :id, :name
    node(:completed) { q.number_of_completed(@group.id) }
  end

end

child :students, object_root: false do
  attributes :id, :name
end
