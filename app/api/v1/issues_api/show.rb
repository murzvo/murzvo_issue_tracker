# frozen_string_literal: true

class V1::IssuesAPI::Show < Grape::API
  helpers PolicyHelper

  helpers do
    def policy_class
      IssuesPolicy
    end

    def validate!(issue)
      forbidden! unless policy.show?(issue)
    end
  end

  resource :issues do
    desc 'Service to get specific issue by id' do
      headers Authorization: {
        description: 'User auth token',
        required: true
      }
    end

    get ':id', requirements: { id: /[0-9]+/ } do
      issue = Issue.find(params[:id])
      validate!(issue)
      issue
    end
  end
end
