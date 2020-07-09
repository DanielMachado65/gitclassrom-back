# frozen_string_literal: true

module Api
  class ClassroomService
    URL = 'https://gitlab.com/api/v4/'

    def self.all(token)
      find_all_class(token)
    end

    def self.create(params); end

    class << self
      def find_all_class(token)
        HTTParty.get("#{URL}/groups", headers: { 'Authorization' => "Bearer #{token}" })
      end
    end
  end
end
