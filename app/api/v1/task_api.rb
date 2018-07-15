# frozen_string_literal: true

class V1::TaskAPI < Grape::API
  version 'v1', using: :path

  helpers AuthenticationHelper
  before { authenticate! }

  resource :task do
    desc 'User sign up' do
      headers Authorization: {
        description: 'Validates your identity',
        required: true
      }
    end

    get do
      render current_user
    end
  end
end
