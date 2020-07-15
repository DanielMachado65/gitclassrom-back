# frozen_string_literal: true

module Api
  class RepositoryService < ApplicationService
    def initialize(user)
      @user = user
    end

    def all
      response = HTTParty.get("#{URL}/users/#{@user.gitlab_id}/projects", header)
      return not_found unless @response.code == 200

      response
    end

    def get(id)
      response = HTTParty.get("#{URL}/projects/#{id}", header)
      return not_found unless response.code == 200

      response
    end

    private

    def find_or_create(response)
      Repository.find_or_create_by(gitlab_id: response['id'])
    end
  end
end
