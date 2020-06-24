# frozen_string_literal: true

GitClassRoomService::App.controllers :user, map: 'api/v1', provides: :json do
  post :login do
    render(Api::UserService.login(@body))
  end
end
