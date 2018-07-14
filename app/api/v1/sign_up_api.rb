# frozen_string_literal: true

class API::V1::SignUpAPI < Grape::API
  version 'v1', using: :path

  resource :sign_up do
    desc 'User sign up'

    params do
      group :user, type: Hash do
        requires 'username',              type: String, desc: 'user system username'
        requires 'password',              type: String, desc: 'user password'
        requires 'password-confirmation', type: String, desc: 'user password confirmation'
      end
    end

    post do
      return 'hello'
    end
  end
end
