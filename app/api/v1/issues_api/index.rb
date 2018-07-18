# frozen_string_literal: true

class V1::IssuesAPI::Index < Grape::API
  helpers do
    def issues
      return Issue.user_issues(current_user) if params[:status].blank?
      Issue.user_issues(current_user).status(params[:status])
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
      optional :status, values: %w[pending in_progress resolved]
    end

    paginate per_page: 25, max_per_page: 25
    get do
      paginate issues
    end
  end
end
