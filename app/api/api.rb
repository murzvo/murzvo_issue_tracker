# frozen_string_literal: true

class API < Grape::API
  mount API::V1::Root

  add_swagger_documentation mount_path: '/docs'
end
