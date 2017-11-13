class ProfessorsController < ApplicationController

  def auth
    @professor = Professor.authenticate(params[:email], params[:password])

    api_response(@professor, 'professors/auth')
  end

  def register
    @professor = Professor.create!(professor_params)

    api_response(@professor, 'professors/auth', 403)
  end


  private

  def professor_params
    params.permit(:name, :email, :password)
  end

end
