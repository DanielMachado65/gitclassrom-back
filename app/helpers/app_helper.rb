# frozen_string_literal: true

GitClassRoomService::App.helpers do
  def render_errors(service)
    status 400
    { "errors": service }.to_json
  end

  def render_not_authorized
    halt 401, {'Content-Type' => 'text/plain'}, 'Não está autorizado!'
  end

  def render_not_found(service)
    status 404
    { "error": service }.to_json
  end

  def render_success(service)
    status 200
    service.to_json
  end

  def render_created(service)
    status 200
    service.to_json
  end

  def render(service, created = false)
    return render_success(msg: service) if service.is_a? String
    return render_errors(service[:error]) if service[:code] == 400
    return render_not_found(service[:error]) if service[:code] == 404

    created ? render_created(service) : render_success(service)
  end

  def bearer_token
    pattern = /^Bearer /
    header = env['HTTP_AUTHORIZATION']
    @bearer_token = header.gsub(pattern, '') if header&.match(pattern)
  end
end
