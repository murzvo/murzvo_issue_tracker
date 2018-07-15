# frozen_string_literal: true

require 'jwt'

module JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, 'dfjijsd89fsy7d8ftd')
  end

  # Decodes the JWT with the signed secret
  def self.decode(token)
    HashWithIndifferentAccess.new(JWT.decode(token, 'dfjijsd89fsy7d8ftd')[0])
  rescue StandardError
    nil
  end
end
