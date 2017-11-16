class QuizzesController < ApplicationController
  def professor_quizzes
    @quizzes = Quiz.where(professor_id: params[:id])

    api_response(@quizzes, 'quizzes/professor_quizzes')
  end

  def create
    @quiz = Quiz.create!(quiz_params)

    unless @quiz.nil?
      params[:questions].each do |q_id|
        QuestionToQuizAssignation.create!(question_id: q_id, quiz_id: @quiz.id)
      end
    end

    api_response(@quiz, 'quizzes/show_quiz')
  end

  def update
    @quiz = Quiz.find_by(id: params[:id])
    @quiz.update_attributes(quiz_params)

    unless @quiz.nil?
      to_delete = @quiz.questions_ids
      to_add = params[:questions]

      (to_delete - to_add).each do |quest_id|
          QuestionToQuizAssignation.where('question_id = ? AND quiz_id = ?', quest_id, @quiz.id).delete_all
      end

      (to_add - to_delete).each do |quest_id|
          QuestionToQuizAssignation.create!(question_id: quest_id, quiz_id: @quiz.id)
      end

      @quiz.reload
    end

    api_response(@quiz, 'quizzes/show_quiz')
  end

  def get_resource
    @quiz = QuizToGroupAssignation.find_by(id: params[:id])

    api_response(@quiz, 'quizzes/resource')
  end

  def get_questions
    @quiz = QuizToGroupAssignation.find_by(id: params[:id])

    api_response(@quiz, 'quizzes/show_as_exam')
  end

  def create_attempt
    assignation = QuizToGroupAssignation.find(params[:id])
    @attempt = Attempt.create!(quiz_id: assignation.quiz_id, group_id: assignation.quiz_id, student_id: params[:studentId]) unless assignation.nil?

    unless @attempt.nil?
      params[:answers].each do |answer|
        AttemptAnswer.create!(question_id: answer[:id], attempt_id: @attempt.id, answer: answer[:answer])
      end
      @attempt.calculate_grade
    end

    api_response(@attempt, 'quizzes/attempt_result')
  end

  private

  def quiz_params
    h = params.permit(:name)
    h[:professor_id] = params[:teacherId] unless params[:teacherId].nil?
    h[:resource_url] = params[:resource]
    h[:resource_type] = params[:resourceType]
    h
  end

  def attempt_params
    # deprecated
    h = {assignation_id: [:id], student_id: params[:studentId]}
  end
end
