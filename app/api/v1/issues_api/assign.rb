# frozen_string_literal: true

class V1::IssuesAPI::Assign < Grape::API
  helpers PolicyHelper

  helpers do
    def policy_class
      IssuesPolicy
    end

    def validate!(issue)
      error!('Issue is already assigned', 402) if issue.assigned?
      error!('Issue can not be assigned to this user', 402) unless policy.assign?(issue, params[:assignee_id])
    end
  end

  resource :issues do
    desc 'Service to assign user to the issue' do
      headers Authorization: {
        description: 'User auth token',
        required: true
      }
    end

    params do
      requires :assignee_id, type: Integer, desc: 'ID of User that should be assigned to task'
    end

    put ':id/assign', requirements: { id: /[0-9]+/ } do
      issue = Issue.find(params[:id])
      validate!(issue)
      issue.update(assignee_id: params[:assignee_id])
      issue
    end
  end
end
