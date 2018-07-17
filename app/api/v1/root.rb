# frozen_string_literal: true

class V1::Root < Grape::API
  version 'v1', using: :path, cascade: true

  error_formatter :json, V1::Helpers::ErrorResponseFormatter

  use V1::Helpers::ApiErrorsHandler

  mount V1::SignUpAPI
  mount V1::SessionAPI
  mount V1::IssuesAPI::Root
end
