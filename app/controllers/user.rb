# frozen_string_literal: true

GitClassRoomService::App.controllers :user, map: 'api/v1', provides: :json do

  get :login do
    'hello world'
  end
end
