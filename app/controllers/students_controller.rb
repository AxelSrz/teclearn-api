class StudentsController < ApplicationController
  def auth
    @student = Student.authenticate(params[:email], params[:password])

    api_response(@student, 'students/auth')
  end

  def register
    @student = Student.create!(student_params)

    api_response(@student, 'students/auth', 403)
  end

  def group_overview
    student = Student.includes(:groups).find(params[:student_id])
    @overview = nil
    unless student.nil?
      @overview = student.get_group_overview(params[:group_id])
    end

    api_response(@overview, 'students/group_overview')
  end

  def get_state
    @student = Student.find_by(id: params[:id])

    api_response(@student, 'students/state')
  end

  def set_state
    @student = Student.find(params[:id])
    @student.update_attributes(state_params)
    
    api_response(@student, 'students/state')
  end

  private

  def student_params
    params.permit(:name, :email, :password)
  end

  def state_params
    params.permit(:state)
  end

end
