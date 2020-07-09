# frozen_string_literal: true

GitClassRoomService::App.controllers :user, map: 'api/v1', provides: :json do
  before :update, :me do
    bearer_token
  end

  get :me do
    render(Api::UserService.get_user(@bearer_token))
  end

  post :login do
    render(Api::UserService.login(@body))
  end

  put :update, map: 'users' do
    render(Api::UserService.update(@body))
  end

  get :find_user, map: 'users/:id' do
    render(Api::UserService.get_user_by_gitlab(params[:id]))
  end
end
