# frozen_string_literal: true

class API::V1::Root < Grape::API
  version 'v1', using: :path, cascade: true

  mount API::V1::SignUpAPI
end
