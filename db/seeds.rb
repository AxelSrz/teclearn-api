# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
serrano = Professor.create!(name: 'Alfonso Serrano', email: 'serrano@itesm.mx', password: 'fisica', password_confirmation: 'fisica')
jackie = Professor.create!(name: 'Jackeline Marcos', email: 'jackie@itesm.mx', password: 'apis', password_confirmation: 'apis')

q = Question.create!([
  {
    question_description: '¿Cuantas leyes de Newton hay?',
    professor_id: serrano.id,
    option_1: '3',
    option_2: '4',
    option_3: '2',
    option_4: '5'
  },
  {
    question_description: 'La acelerción de la gravedad es ...',
    professor_id: serrano.id,
    option_1: '9.8 m/s',
    option_2: '8.9 m/s',
    option_3: '4.5 m/s',
    option_4: '8.5 m/s'
  },
  {
    question_description: '¿Cuál gráfica es la resultante de integrar la relación velocidad sobre tiempo?',
    professor_id: serrano.id,
    option_1: 'Distancia',
    option_2: 'Acelerción',
    option_3: 'Velocidad al cuadrado'
  }])

t1 = Tag.create!(professor_id: serrano.id, name: 'física')
t2 = Tag.create!(professor_id: serrano.id, name: 'cinética')

TagToQuestionAssignation.create!(tag_id: t1.id, question_id: q[2].id)
TagToQuestionAssignation.create!(tag_id: t2.id, question_id: q[2].id)
TagToQuestionAssignation.create!(tag_id: t2.id, question_id: q[0].id)
TagToQuestionAssignation.create!(tag_id: t2.id, question_id: q[1].id)

quizu = Quiz.create!(professor_id: serrano.id, name: 'Quiz de cinética', resource_url: 'https://youtu.be/S3QlbbUmszE', resource_type: 'youtube')

QuestionToQuizAssignation.create!(question_id: q[0].id, quiz_id: quizu.id)
QuestionToQuizAssignation.create!(question_id: q[1].id, quiz_id: quizu.id)
QuestionToQuizAssignation.create!(question_id: q[2].id, quiz_id: quizu.id)

group = Group.create!(professor_id: serrano.id, name: 'Física 1', start_date: Date.yesterday, end_date: Date.yesterday >> 4)
group2 = Group.create!(professor_id: serrano.id, name: 'Física 2', start_date: Date.yesterday, end_date: Date.yesterday >> 4)
group3 = Group.create!(professor_id: serrano.id, name: 'Física 3', start_date: Date.yesterday, end_date: Date.yesterday >> 4)

QuizToGroupAssignation.create!(quiz_id: quizu.id, group_id: group.id, expires_at: Date.today >> 1)

meme = Student.create!(name: 'Mely', email: 'melytc@gmail.com', password: 'axel', password_confirmation: 'axel')
cas = Student.create!(name: 'Cass', email: 'cass@gmail.com', password: 'joe', password_confirmation: 'joe')
giulia = Student.create!(name: 'Giulia', email: 'giulia@gmail.com', password: 'alex', password_confirmation: 'alex')

StudentToGroupAssignation.create!(student_id: meme.id, group_id: group.id)
StudentToGroupAssignation.create!(student_id: cas.id, group_id: group.id)

a2 = Attempt.create!(student_id: meme.id, quiz_id: quizu.id, group_id: group.id)

AttemptAnswer.create!(question_id: q[0].id, attempt_id: a2.id, answer: '3')
AttemptAnswer.create!(question_id: q[1].id, attempt_id: a2.id, answer: '9.8 m/s')
AttemptAnswer.create!(question_id: q[2].id, attempt_id: a2.id, answer: 'Aceleración')

a2.calculate_grade

a1 = Attempt.create!(student_id: meme.id, quiz_id: quizu.id, group_id: group.id)

AttemptAnswer.create!(question_id: q[0].id, attempt_id: a1.id, answer: '3')
AttemptAnswer.create!(question_id: q[1].id, attempt_id: a1.id, answer: '9.8 m/s')
AttemptAnswer.create!(question_id: q[2].id, attempt_id: a1.id, answer: 'Distancia')

a1.calculate_grade

a3 = Attempt.create!(student_id: cas.id, quiz_id: quizu.id, group_id: group.id)

AttemptAnswer.create!(question_id: q[0].id, attempt_id: a3.id, answer: '3')
AttemptAnswer.create!(question_id: q[1].id, attempt_id: a3.id, answer: '9.8 m/s')
AttemptAnswer.create!(question_id: q[2].id, attempt_id: a3.id, answer: 'Distancia')

a3.calculate_grade
