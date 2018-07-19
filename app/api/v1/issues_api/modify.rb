# frozen_string_literal: true

class V1::IssuesAPI::Modify < Grape::API
  ASSIGN_REQUIRED_STATUSES = %w[in_progress resolved].freeze

  helpers PolicyHelper

  helpers do
    def policy_class
      IssuesPolicy
    end

    def status_change?(issue)
      params[:status] && issue.status != params[:status]
    end

    def validate!(issue)
      forbidden! unless policy.modify?(issue)
      error!('You can not change status of this issue', 402) if status_change?(issue) && !policy.change_status?(issue)
    end
  end

  resource :issues do
    desc 'Service to modify the issue' do
      headers Authorization: {
        description: 'User auth token',
        required: true
      }
    end

    params do
      optional :name,        type: String
      optional :description, type: String
      optional :status,
               type: String,
               values: %w[pending in_progress resolved],
               desc: 'Issue status. Should be one of following [pending in_progress resolved]'
    end

    put ':id', requirements: { id: /[0-9]+/ } do
      issue = Issue.find(params[:id])
      validate!(issue)
      issue.name = params[:name] if params[:name].present?
      issue.description = params[:description] if params[:description].present?
      issue.status = params[:status] if params[:status].present?
      if issue.save
        issue
      else
        error! issue.errors, 402
      end
    end
  end
end
