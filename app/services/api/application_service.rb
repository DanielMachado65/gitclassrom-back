# frozen_string_literal: true

class Api::ApplicationService
  URL = 'https://gitlab.com/api/v4'

  def header
    { headers: { 'Authorization' => "Bearer #{@user.token}" } }
  end

  def not_found
    { code: 404, error: 'não foi possivel localizar no gitlab' }
  end
end
