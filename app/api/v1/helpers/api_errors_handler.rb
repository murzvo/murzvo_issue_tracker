# frozen_string_literal: true

class V1::Helpers::ApiErrorsHandler < Grape::Middleware::Base
  def call!(env)
    @env = env
    begin
      @app.call(@env)
    rescue Grape::Exceptions::ValidationErrors => e
      throw :error, message: e.full_messages, status: 400
    rescue ActiveRecord::RecordNotFound => e
      throw :error, message: e.message, status: 404
    rescue StandardError
      throw :error, message: 'Oh, something went wrong, pls contact our support', status: 500
    end
  end
end
