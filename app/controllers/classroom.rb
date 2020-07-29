# frozen_string_literal: true

GitClassRoomService::App.controllers :classroom, map: 'api/v1/classroom',
                                                 provides: :json do
  before do
    bearer_token
    @klass = Api::ClassroomService.new(current_user)
  
    return render_not_authorized if @bearer_token.nil?
  end

  get :show, map: ':id' do
    render(@klass.find(params[:id]))
  end

  post :create, map: '' do
    render(@klass.create(@body))
  end
end
