# frozen_string_literal: true

module Api
  class UserService
    def self.login(params)
      response = authenticate(params['token'])
      return find_or_create(response['access_token']) if response.code == 200

      { code: 400, error: 'Não pode formar o token' }
    end

    def self.get_user(token)
      user = find_by_token(token)
      return { code: 404, error: 'não foi possivel localizar' } if user.nil?

      user
    end

    def self.get_user_by_gitlab(id)
      response = find_by_gitlab(id)
      return { code: 404, error: 'não foi possivel localizar no gitlab' } unless response.code == 200

      user = find(response['id'])
      
      return { code: 400, error: 'Não foi possivel localizar' } if user.nil?
    end

    def self.update(params)
      user = find_by_token(params['token'])
      return { code: 400, error: 'Não pode atualizar' } if user.nil?

      return user if user.update(params)

      { code: 400, error: 'Não pode atualizar' }
    end

    class << self
      def authenticate(token)
        HTTParty.post('https://gitlab.com/oauth/token', body: {
                        client_id: ENV['APP_ID'],
                        client_secret: ENV['APP_SECRET'],
                        code: token,
                        grant_type: 'authorization_code',
                        redirect_uri: 'http://localhost:8080/authenticate'
                      })
      end

      def me(token)
        HTTParty.get('https://gitlab.com/api/v4/user', headers: { 'Authorization' => "Bearer #{token}" })
      end

      def find_by_gitlab(id)
        HTTParty.get("https://gitlab.com/api/v4/users/#{id}")
      end

      def find(id)
        User.find_by(gitlab_id: id)
      end

      def find_or_create(token)
        user_gitlab = me(token)
        user = User.find_or_create_by(gitlab_id: user_gitlab['id'])
        user.update(email: user_gitlab['email'],
                    username: user_gitlab['username'],
                    name: user_gitlab['name'],
                    avatar_url: user_gitlab['avatar_url'],
                    token: token)
        return user if user.persisted?

        { code: 400, error: 'Contacte o administrador' }
      end

      def find_by_token(token)
        response = me(token)
        return nil if response.code != 200

        find(response['id'])
      end
    end
  end
end
