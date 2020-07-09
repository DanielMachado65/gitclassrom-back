# frozen_string_literal: true

GitClassRoomService::App.controllers :classroom, map: 'api/v1/classroom',
                                                 provides: :json do
  before do
    bearer_token
    return render_not_authorized if @bearer_token.nil?
  end

  get :show, map: '' do
    render(Api::ClassroomService.all(@bearer_token))
  end

  post :create, map: '' do
    render(Api::ClassroomService.create(@body))
  end
end
