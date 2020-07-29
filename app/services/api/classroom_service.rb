# frozen_string_literal: true

module Api
  class ClassroomService < ApplicationService

    def initialize(user) super(user); end

    def find(id)
      klass = find_klass(id)
      return not_found unless klass.code == 200

      klass
    end

    def create(body)
      klass = create_klass(body)
    end

    private

    def find_klass(id)
      _get "#{URL}/groups/#{id}"
    end

    def create_klass(body)
      _post "#{URL}/groups", { name: body['name'],
                               path: create_path(body['name']),
                               description: body['description'],
                               parent_id: body['parent_id'] }
    end
  end
end
