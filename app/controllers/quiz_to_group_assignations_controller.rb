class QuizToGroupAssignationsController < ApplicationController
  def create
    @quiz_to_group_assignations = []

    if !params[:groupsId].nil?
      params[:groupsId].each do |g_id|
          @quiz_to_group_assignations.push(QuizToGroupAssignation.create!(quiz_id: params[:examId], group_id: g_id, expires_at: Time.at(params[:expiresAt]).in_time_zone.to_date))
      end
    end

    api_response(@quiz_to_group_assignations, 'quiz_to_group_assignations/create')
  end

  def update
    @quiz_to_group_assignation = QuizToGroupAssignation.find_by(id: params[:id])
    @quiz_to_group_assignation.update_attributes(assignation_params)

    api_response(@quiz_to_group_assignation, 'quiz_to_group_assignations/update')
  end

  private

  def assignation_params
    h = { expires_at: Time.at(params[:expiresAt]).in_time_zone.to_date }
  end
end
