# frozen_string_literal: true

class V1::Root < Grape::API
  version 'v1', using: :path, cascade: true

  # formatter       :json, SuccesResponseFormatter
  # error_formatter :json, ErrorResponseFormatter

  mount V1::SignUpAPI
  mount V1::SessionAPI
  mount V1::TaskAPI
end
