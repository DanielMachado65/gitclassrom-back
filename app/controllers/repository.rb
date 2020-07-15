# frozen_string_literal: true

GitClassRoomService::App.controllers :repository, map: 'api/v1/repository',
                                                  provides: :json do
  before do
    bearer_token
    @repository = Api::RepositoryService.new(current_user)

    return render_not_authorized if @bearer_token.nil?
  end

  get :all, map: '' do
    render(@repository.all)
  end

  get :show, map: ':id' do
    render(@repository.get(params[:id]))
  end
end
