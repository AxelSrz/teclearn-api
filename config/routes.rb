Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Teacher login
  post '/teacher_login', to: 'professors#auth', as: 'auth_professor'

  # Student login
  post '/student_login', to: 'students#auth', as: 'auth_student'

  # Teacher login
  post '/teacher_register', to: 'professors#register', as: 'register_professor'

  # Student login
  post '/student_register', to: 'students#register', as: 'register_student'

  # Teacher's Groups Collection
  get '/teacher_groups/:id', to: 'groups#find_professor_groups', as: 'groups_by_professor'
  post '/teacher_groups', to: 'groups#create', as: 'create_group'
  patch '/teacher_groups/:id', to: 'groups#update', as: 'update_group'

  # Teacher's Overview
  # TODO mandar el assignation_id en lugar del id del grupo
  get '/teacher_overview/:id', to: 'groups#overview', as: 'groups_overview'

  # Teacher Group Exam Collection {checa POST}
  # TODO checar que id me manda
  post '/teacher_groups_exams', to: 'quiz_to_group_assignations#create', as: 'assign_quiz_to_groups'
  patch '/teacher_groups_exams', to: 'quiz_to_group_assignations#update', as: 'update_quiz_to_groups'

  # Teacher Exams Collection
  get '/teacher_exams/:id', to: 'quizzes#professor_quizzes', as: 'professor_quizzes'
  post '/teacher_exams', to: 'quizzes#create', as: 'create_quiz'
  patch '/teacher_exams', to: 'quizzes#update', as: 'update_quiz'

  # Teacher Questions Collection
  get '/teacher_questions/:id', to: 'questions#professor_questions', as: 'professor_questions'
  post '/teacher_questions', to: 'questions#create', as: 'create_question'
  patch '/teacher_questions', to: 'questions#update', as: 'update_question'

  # Teacher Tags Collection
  get '/teacher_tags/:id', to: 'tags#professor_tags', as: 'professor_tags'

  # Group Exam Results Collection
  get '/group_exam_results/:group_id/:quiz_id', to: 'exam_results#get', as: 'exam_results'

  # Group Results Collection
  get '/group_results/:group_id', to: 'group_results#get', as: 'group_results'

  # Student Groups Collection   {checa POST si quiere solo el nuevo o todos}
  get '/student_groups/:student_id', to: 'groups#find_student_groups', as: 'student_groups'
  post '/student_groups', to: 'groups#add_student_to_group', as: 'add_student_to_group'

  # Student Overview {checa GET necesita 2 ids y solo me esta mandando 1}
  get '/student_overview/:student_id/:group_id', to: 'students#group_overview', as: 'student_group_overview'

  # Student State
  get '/student_state/:id', to: 'students#get_state', as: 'get_student_state'
  post '/student_state', to: 'students#set_state', as: 'set_student_state'

  # Exam Resources
  get '/resources/:id', to: 'quizzes#get_resource', as: 'get_quiz_resource'

  # Exam Questions
  get '/exam/:id', to: 'quizzes#get_questions', as: 'get_quiz_questions'
  post '/exam', to: 'quizzes#create_attempt', as: 'create_quiz_attempt'

end
