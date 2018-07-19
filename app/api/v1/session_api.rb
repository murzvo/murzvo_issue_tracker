# frozen_string_literal: true

class V1::SessionAPI < Grape::API
  desc 'Service to authenticate user' do
    detail 'When authenticate is successful user token will be returned'
  end

  helpers AuthenticationHelper

  resource :session do
    params do
      requires :username, type: String
      requires :password, type: String
    end

    post do
      user = User.find_by(username: params[:username])
      if user&.authenticate(params[:password])
        { token: JsonWebToken.encode(user_id: user.id) }
      else
        fail_auth!
      end
    end
  end
end
