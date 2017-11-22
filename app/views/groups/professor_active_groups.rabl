collection @groups

attributes :id, :name
attribute number_of_active_quizzes: :activeQuizzes

node(:startDate) { |group| group.start_date.to_time.to_i * 1000 }
node(:endDate) { |group| group.end_date.to_time.to_i * 1000 }
