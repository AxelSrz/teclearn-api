object @group

attributes :id, :highestGrades, :recentGrades

child :quizzes, root: 'exams', object_root: false do
  attribute :id, :name
end
