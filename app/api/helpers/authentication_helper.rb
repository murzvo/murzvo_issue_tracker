# frozen_string_literal: true

module AuthenticationHelper
  TOKEN_PARAM_NAME = 'Authorization'

  def encoded_token(token_param = TOKEN_PARAM_NAME)
    request.headers[token_param]
  end

  def fail_auth!
    error!('Incorrect username or password', 401)
  end

  def current_user
    decoded_token = JsonWebToken.decode(encoded_token)
    fail_auth! if decoded_token.blank?
    @current_user ||= User.find(decoded_token[:user_id])
  end

  def authenticate!
    fail_auth! unless current_user
  end
end
