# frozen_string_literal: true

GitClassRoomService::App.helpers do
  def current_user
    @current_user ||= User.find_by(token: @bearer_token)
  end
end
