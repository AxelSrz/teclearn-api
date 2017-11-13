class GroupsController < ApplicationController

  def find_professor_groups
    @groups = Group.where(professor_id: params[:id])

    api_response(@groups, 'groups/professor_active_groups')
  end

  def find_student_groups
    @groups = Student.includes(:groups).find(params[:student_id]).groups

    api_response(@groups, 'groups/student_active_groups')
  end

  def create
    @group = Group.create!(group_params)

    api_response(@group, 'groups/new_group')
  end

  def update
    @group = Group.find_by(id: params[:id])
    @group.update_attributes(update_group_params)

    api_response(@group, 'groups/update_group')
  end

  def overview
    @group = Group.find_by(id: params[:id])

    api_response(@group, 'groups/overview')
  end

  def add_student_to_group
    @group = nil
    aux_group = Group.find_by(access_code: params[:groupCode])

    unless aux_group.nil?
      assignation = StudentToGroupAssignation.create!(student_id: params[:studentId], group_id: aux_group.id)
      @group = assignation.nil? ? nil : aux_group
    end

    api_response(@group, 'groups/student_new_group')
  end

  private

  def group_params
    h = params.permit(:name)
    h[:start_date] = Time.at(params[:startDate]).in_time_zone.to_date
    h[:end_date] = Time.at(params[:endDate]).in_time_zone.to_date
    h[:professor_id] = params[:teacherId]
    h
  end

  def update_group_params
    h = params.permit(:id, :name)
    if !h[:start_date].nil?
      h[:start_date] = Time.at(params[:startDate]).in_time_zone.to_date
    end
    if !h[:end_date].nil?
      h[:end_date] = Time.at(params[:endDate]).in_time_zone.to_date
    end
    h
  end

end
