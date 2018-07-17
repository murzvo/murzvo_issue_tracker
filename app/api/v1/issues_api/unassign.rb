# frozen_string_literal: true

class V1::IssuesAPI::Unassign < Grape::API
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

    put ':id/unassign', requirements: { id: /[0-9]+/ } do
      issue = Issue.find(params[:id])
      error!('Issue is already unassigned', 402) unless issue.assigned?
      error!('Issue can not be unassigned from this user', 402) unless policy.unassign?(issue)
      issue.update(assignee_id: nil)
      issue
    end
  end
end
