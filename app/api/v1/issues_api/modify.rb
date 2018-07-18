# frozen_string_literal: true

class V1::IssuesAPI::Modify < Grape::API
  ASSIGN_REQUIRED_STATUSES = %w[in_progress resolved].freeze

  helpers PolicyHelper

  helpers do
    def policy_class
      IssuesPolicy
    end

    def status_change?
      issue.status != params[:status]
    end

    def issue
      Issue.find(params[:id])
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
      optional 'name',        type: String, desc: ''
      optional 'description', type: String, desc: ''
      optional 'status',      type: String, values: %w[pending in_progress resolved], desc: ''
    end

    put ':id', requirements: { id: /[0-9]+/ } do
      forbidden! unless policy.modify?(issue)
      error!('You can not change status of your issue', 402) unless policy.change_status?(issue)
      issue.update(
        name: params[:name],
        description: params[:description],
        status: params[:status]
      )
      issue.as_json(only: %i[id name description status assignee_id creator_id created_at])
    end
  end
end
