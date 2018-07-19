# frozen_string_literal: true

class V1::SignUpAPI < Grape::API
  namespace :sign_up do
    desc 'Creates user with specific role' do
      detail 'Service that creates new user.
              Role field added to be able to create users with specific role
              since there is no roles management for users.'
    end

    params do
      requires :username, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
      requires :role,
               type: String,
               values: %w[regular manager],
               desc: 'User role. Role should be one of the following [regular manager]'
    end

    post do
      user = User.new(params)
      if user.save
        user
      else
        error! user.errors, 402
      end
    end
  end
end
