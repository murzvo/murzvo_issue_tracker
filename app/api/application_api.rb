# frozen_string_literal: true

class ApplicationApi < Grape::API
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  prefix "api"

  mount V1::Root

  add_swagger_documentation mount_path: '/docs'
end
