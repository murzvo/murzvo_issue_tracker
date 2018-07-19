# frozen_string_literal: true

class V1::IssuesAPI::Unassign < Grape::API
  ASSIGN_REQUIRED_STATUSES = %w[in_progress resolved].freeze

  helpers PolicyHelper

  helpers do
    def policy_class
      IssuesPolicy
    end

    def validate!(issue)
      error!('Issue is already unassigned', 402) unless issue.assigned?
      error!('Issue can not be unassigned from this user', 402) unless policy.unassign?(issue)
      if ASSIGN_REQUIRED_STATUSES.include?(issue.status)
        error!("Issue with status #{issue.status.humanize} can not be unassigned", 402)
      end
    end
  end

  resource :issues do
    desc 'Service to unassign user from the issue' do
      headers Authorization: {
        description: 'User auth token',
        required: true
      }
    end

    put ':id/unassign', requirements: { id: /[0-9]+/ } do
      issue = Issue.find(params[:id])
      validate!(issue)
      issue.update(assignee_id: nil)
      issue
    end
  end
end
