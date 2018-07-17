# frozen_string_literal: true

class V1::IssuesAPI::Root < Grape::API
  version 'v1', using: :path

  helpers AuthenticationHelper
  before { authenticate! }

  mount V1::IssuesAPI::Index
  mount V1::IssuesAPI::Show
  mount V1::IssuesAPI::Create
  mount V1::IssuesAPI::Modify
  mount V1::IssuesAPI::Delete
  mount V1::IssuesAPI::Assign
  mount V1::IssuesAPI::Unassign
end
