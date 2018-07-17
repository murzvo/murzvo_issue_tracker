# frozen_string_literal: true

class V1::IssuesAPI::Show < Grape::API
  helpers PolicyHelper

  helpers do
    def policy_class
      IssuesPolicy
    end
  end

  resource :issues do
    desc 'API with actions with issues' do
      headers Authorization: {
        description: 'Validates your identity',
        required: true
      }
    end

    get ':id', requirements: { id: /[0-9]+/ } do
      issue = Issue.find(params[:id])
      forbidden! unless policy.show?(issue)
      issue
    end
  end
end
