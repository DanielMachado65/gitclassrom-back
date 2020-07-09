# frozen_string_literal: true

module Api
  class ClassroomService
    URL = 'https://gitlab.com/api/v4/'

    def self.all(token)
      find_all_class(token)
    end

    def self.create(token, params)
      binding.pry

      response = create_class(token, {
        name: params['name'],
        path: params['path'],
        description: params['description'],
        parent_id: params['parent_id']
      })

      
      
    end

    class << self
      def find_all_class(token)
        HTTParty.get("#{URL}/groups", headers: { 'Authorization' => "Bearer #{token}" })
      end

      def create_class(token, body)
        HTTParty.post("#{URL}/groups", body: body, headers: { 'Authorization' => "Bearer #{token}" })
      end
    end
  end
end
