# frozen_string_literal: true

class V1::IssuesAPI::Assign < Grape::API
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

    params do
      requires 'assignee_id', type: Integer, desc: ''
    end

    put ':id/assign', requirements: { id: /[0-9]+/ } do
      issue = Issue.find(params[:id])
      error!('Issue is already assigned to this user', 402) if issue.assignee_id == params[:assignee_id]
      error!('Issue can not be assigned to this user', 402) unless policy.assign?(issue, params[:assignee_id])
      issue.update(assignee_id: current_user.id)
      issue
    end
  end
end
