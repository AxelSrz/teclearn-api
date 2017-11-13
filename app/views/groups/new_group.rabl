collection @group

attributes :id, :name
attribute number_of_active_quizzes: :activeQuizzes

node(:startDate) { @group.start_date.to_time.to_i }
node(:endDate) { @group.end_date.to_time.to_i }
