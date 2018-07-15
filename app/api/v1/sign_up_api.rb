# frozen_string_literal: true

class V1::SignUpAPI < Grape::API
  version 'v1', using: :path

  namespace :sign_up do
    desc 'User sign up'

    params do
      group :user, type: Hash do
        requires 'username', type: String, desc: 'user system username'
        requires 'password', type: String, desc: 'user password'
        requires 'password_confirmation', type: String, desc: 'user password'
      end
    end

    post do
      user = User.new(params[:user])
      user.save
      user
    end
  end
end
