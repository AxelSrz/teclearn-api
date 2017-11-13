class GroupResultsController < ApplicationController
  def get
    @group = Group.includes(:quizzes,:students).find_by(id: params[:group_id])

    api_response(@group, 'group_results/show')
  end
end
