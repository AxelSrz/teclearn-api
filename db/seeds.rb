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
    question_description: 'La respuesta es correcta',
    professor_id: serrano.id,
    option_1: 'correcta',
    option_2: 'incorrecta',
    option_3: 'incorrecta tambien',
    option_4: 'noup'
  },
  {
    question_description: 'Who is best grill?',
    professor_id: serrano.id,
    option_1: 'JC-chan',
    option_2: 'Axel-kun',
    option_3: 'Joe-san',
    option_4: 'Henkel-sama'
  },
  {
    question_description: 'Pizza with...',
    professor_id: serrano.id,
    option_1: 'Ham & Pineapple',
    option_2: 'Pineapple',
    option_3: 'Ham'
  }])

t1 = Tag.create!(professor_id: serrano.id, name: 'food')
t2 = Tag.create!(professor_id: serrano.id, name: 'plox')

TagToQuestionAssignation.create!(tag_id: t1.id, question_id: q[2].id)
TagToQuestionAssignation.create!(tag_id: t2.id, question_id: q[2].id)
TagToQuestionAssignation.create!(tag_id: t2.id, question_id: q[0].id)
TagToQuestionAssignation.create!(tag_id: t2.id, question_id: q[1].id)

quizu = Quiz.create!(professor_id: serrano.id, name: 'Fuerza, mushashos', resource_url: 'https://youtu.be/9mD-ZmWuFTQ', resource_type: 'video')

QuestionToQuizAssignation.create!(question_id: q[0].id, quiz_id: quizu.id)
QuestionToQuizAssignation.create!(question_id: q[1].id, quiz_id: quizu.id)
QuestionToQuizAssignation.create!(question_id: q[2].id, quiz_id: quizu.id)

group = Group.create!(professor_id: serrano.id, name: 'Fisiquisha 1', start_date: Date.yesterday, end_date: Date.yesterday >> 4)
group2 = Group.create!(professor_id: serrano.id, name: 'Fisiquisha 2', start_date: Date.yesterday, end_date: Date.yesterday >> 4)
group3 = Group.create!(professor_id: serrano.id, name: 'Fisiquisha 3', start_date: Date.yesterday, end_date: Date.yesterday >> 4)

QuizToGroupAssignation.create!(quiz_id: quizu.id, group_id: group.id, expires_at: Date.today >> 1)

meme = Student.create!(name: 'Mely', email: 'melytc@gmail.com', password: 'axel', password_confirmation: 'axel')
cas = Student.create!(name: 'Cass', email: 'cass@gmail.com', password: 'joe', password_confirmation: 'joe')
giulia = Student.create!(name: 'Giulia', email: 'giulia@gmail.com', password: 'alex', password_confirmation: 'alex')

StudentToGroupAssignation.create!(student_id: meme.id, group_id: group.id)
StudentToGroupAssignation.create!(student_id: cas.id, group_id: group.id)

a2 = Attempt.create!(student_id: meme.id, quiz_id: quizu.id, group_id: group.id)

AttemptAnswer.create!(question_id: q[0].id, attempt_id: a2.id, answer: 'correcta')
AttemptAnswer.create!(question_id: q[1].id, attempt_id: a2.id, answer: 'JC-chan')
AttemptAnswer.create!(question_id: q[2].id, attempt_id: a2.id, answer: 'Ham & Pineapple')

a2.calculate_grade

a1 = Attempt.create!(student_id: meme.id, quiz_id: quizu.id, group_id: group.id)

AttemptAnswer.create!(question_id: q[0].id, attempt_id: a1.id, answer: 'correcta')
AttemptAnswer.create!(question_id: q[1].id, attempt_id: a1.id, answer: 'Axel-kun')
AttemptAnswer.create!(question_id: q[2].id, attempt_id: a1.id, answer: 'Ham & Pineapple')

a1.calculate_grade

a3 = Attempt.create!(student_id: cas.id, quiz_id: quizu.id, group_id: group.id)

AttemptAnswer.create!(question_id: q[0].id, attempt_id: a3.id, answer: 'correcta')
AttemptAnswer.create!(question_id: q[1].id, attempt_id: a3.id, answer: 'JC-chan')
AttemptAnswer.create!(question_id: q[2].id, attempt_id: a3.id, answer: 'Ham & Pineapple')

a3.calculate_grade
