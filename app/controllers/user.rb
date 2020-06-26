# frozen_string_literal: true

GitClassRoomService::App.controllers :user, map: 'api/v1', provides: :json do
  before :update do
    bearer_token
  end

  post :login do
    render(Api::UserService.login(@body))
  end

  put :update, map: 'user' do
    render(Api::UserService.update(@body))
  end
end
