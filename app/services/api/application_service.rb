# frozen_string_literal: true

class Api::ApplicationService
  URL = 'https://gitlab.com/api/v4'.freeze

  def initialize(user)
    @user = user
  end

  def header
    { headers: { 'Authorization' => "Bearer #{@user.token}" } }
  end

  def not_found
    { code: 404, error: 'não foi possivel localizar no gitlab' }
  end

  def _get(url)
    HTTParty.get(url, header)
  end
  
  def _post(url, body={})
    HTTParty.get(url, header.merge(body: body))
  end

  def create_path(path)
    path&.underscore&.downcase&.gsub(' ', '-')
  end
end
