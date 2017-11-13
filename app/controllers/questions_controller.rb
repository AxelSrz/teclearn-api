class QuestionsController < ApplicationController
  def professor_questions
    @questions = Question.where(professor_id: params[:id])

    api_response(@questions, 'questions/professor_questions')
  end

  def create
    @question = Question.create!(question_params)

    unless @question.nil?
      params[:tags].each do |t_id|
        TagToQuestionAssignation.create!(tag_id: t_id, question_id: @question.id)
      end

      params[:new_tags].each do |tag|
        t_aux = Tag.create!(professor_id: params[:teacherId], name: tag)
        TagToQuestionAssignation.create!(tag_id: t_aux.id, question_id: @question.id)
      end
    end

    api_response(@question, 'questions/show_question')
  end

  def update
    @question = Question.find_by(id: params[:id])
    @question.update_attributes(question_params)

    unless @question.nil?
      to_delete = @question.tags_ids
      to_add = params[:tags]

      (to_delete - to_add).each do |tag_id|
        TagToQuestionAssignation.where('tag_id = ? AND question_id = ?', tag_id, @question.id).delete_all
      end

      (to_add - to_delete).each do |tag_id|
        TagToQuestionAssignation.create!(tag_id: tag_id, question_id: @question.id)
      end

      params[:new_tags].each do |tag|
        t_aux = Tag.create!(professor_id: params[:teacherId], name: tag)
        TagToQuestionAssignation.create!(tag_id: t_aux.id, question_id: @question.id)
      end

      @question.reload
    end

    api_response(@question, 'questions/show_question')
  end

  private

  def question_params
    incorrect_aux = [:option_2,:option_3,:option_4,:option_5]
    h = {}
    h[:professor_id] = params[:teacherId] unless params[:teacherId].nil?
    h[:question_description] = params[:question]
    h[:option_1] = params[:correctAnswer]
    incorrect = params[:incorrectAnswers]
    if !incorrect.nil?
      incorrect.each_with_index do |option, index|
        h[incorrect_aux[index]] = option
      end
    end
    h
  end

end
