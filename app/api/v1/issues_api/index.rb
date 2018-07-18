# frozen_string_literal: true

class V1::IssuesAPI::Index < Grape::API
  resource :issues do
    desc 'API with actions with issues' do
      headers Authorization: {
        description: 'Validates your identity',
        required: true
      }
    end

    paginate per_page: 25, max_per_page: 25
    get do
      paginate Issue.user_issues(current_user)
    end
  end
end
