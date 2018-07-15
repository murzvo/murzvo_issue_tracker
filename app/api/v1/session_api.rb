# frozen_string_literal: true

class V1::SessionAPI < Grape::API
  version 'v1', using: :path

  helpers AuthenticationHelper

  resource :session do
    desc 'This API is used to create user sessions(sign in/out)'

    params do
      requires 'username', type: String, desc: 'user system username'
      requires 'password', type: String, desc: 'user password'
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
