class ExamResultsController < ApplicationController
  def get
    @quiz_to_group_assignation = QuizToGroupAssignation.find_by(quiz_id: params[:quiz_id], group_id: params[:group_id])

    api_response(@quiz_to_group_assignation, 'group_exam_results/show')
  end
end
