# frozen_string_literal: true

class V1::IssuesAPI::Delete < Grape::API
  helpers PolicyHelper

  helpers do
    def policy_class
      IssuesPolicy
    end

    def validate!(issue)
      forbidden! unless policy.delete?(issue)
    end
  end

  resource :issues do
    desc 'Service to delete an issue by id' do
      detail 'In current implementation users can delete only own issues'

      headers Authorization: {
        description: 'User auth token',
        required: true
      }
    end

    delete ':id', requirements: { id: /[0-9]+/ } do
      issue = Issue.find(params[:id])
      validate!(issue)
      issue.delete
      issue
    end
  end
end
