module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def api_response(object, json_format, fail_status = 404)
    if !object.nil? && object != []
      render json_format
    else
      render json: {}, status: fail_status
    end
  end
end
