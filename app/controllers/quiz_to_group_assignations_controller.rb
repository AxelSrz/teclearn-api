class QuizToGroupAssignationsController < ApplicationController
  def create
    @quiz_to_group_assignations = []
    @group = nil

    if !params[:groupsId].nil?
      params[:groupsId].each do |g_id|
          @quiz_to_group_assignations.push(QuizToGroupAssignation.create!(quiz_id: params[:examId], group_id: g_id, expires_at: Time.at((params[:expiresAt]/1000).floor).in_time_zone.to_date))
      end
      @group = @quiz_to_group_assignations.first.group
    end

    api_response(@group, 'groups/overview')
  end

  def update
    @quiz_to_group_assignation = QuizToGroupAssignation.find_by(id: params[:id])
    @quiz_to_group_assignation.update_attributes(assignation_params)
    @group = @quiz_to_group_assignation.group

    api_response(@group, 'groups/overview')
  end

  private

  def assignation_params
    h = { expires_at: Time.at((params[:expiresAt]/1000).floor).in_time_zone.to_date }
  end
end
