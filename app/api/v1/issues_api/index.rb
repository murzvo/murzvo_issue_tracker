# frozen_string_literal: true

class V1::IssuesAPI::Index < Grape::API
  helpers do
    def issues
      return Issue.user_issues(current_user) if params[:status].blank?
      Issue.user_issues(current_user).status(params[:status])
    end
  end

  resource :issues do
    desc 'Service to get list of issues' do
      headers Authorization: {
        description: 'User auth token',
        required: true
      }
    end

    params do
      optional :status, values: %w[pending in_progress resolved], desc: 'Use this parameter to sort issues by status'
    end

    paginate per_page: 25, max_per_page: 25
    get do
      paginate issues
    end
  end
end
