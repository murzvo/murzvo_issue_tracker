# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

require 'rails_helper'
require 'active_record'
require 'active_model'
require 'pry'

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration for more details.
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on a real object.
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
