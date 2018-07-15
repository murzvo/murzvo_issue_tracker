# frozen_string_literal: true

class V1::SessionAPI < Grape::API
  version 'v1', using: :path

  resource :session do
    desc 'This API is used to create user sessions(sign in/out)'

    params do
      requires 'username', type: String, desc: 'user system username'
      requires 'password', type: String, desc: 'user password'
    end

    post do
      user = User.find_by(username: params[:username])
      if user&.authenticate(params[:password])
        auth_token = ::JsonWebToken.encode(user_id: user.id)
        return auth_token
      else
        return 'unathorized'
      end
    end
  end
end
