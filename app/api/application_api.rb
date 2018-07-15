# frozen_string_literal: true

class ApplicationApi < Grape::API
  format :json

  mount V1::Root

  add_swagger_documentation mount_path: '/docs'
end
