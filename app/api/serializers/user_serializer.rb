require 'jsonapi-serializers'

class UserSerializer
  include JSONAPI::Serializer

  attribute :username
end
