# frozen_string_literal: true

module V1::Helpers::ErrorResponseFormatter
  class << self
    def call(object, *_opts)
      errors_hash = object.is_a?(ActiveModel::Errors) ? object.full_messages : convert_to_errors(object)
      errors_hash.to_json
    end

    private

    def convert_to_errors(object)
      if object.is_a?(Hash) && object.key?(:detail)
        [object]
      elsif object.is_a?(Array)
        object.map { |msg| { detail: msg } }
      else
        [{ detail: object }]
      end
    end
  end
end
