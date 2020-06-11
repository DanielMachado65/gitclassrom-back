# frozen_string_literal: true

GitClassRoomService::App.controllers :products do
  get :show, map: 'index', provides: :json do
    'hello world'
  end
end
