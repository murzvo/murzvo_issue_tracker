# frozen_string_literal: true

class V1::IssuesAPI::Create < Grape::API
  resource :issues do
    desc 'API with actions with issues' do
      headers Authorization: {
        description: 'Validates your identity',
        required: true
      }
    end

    params do
      requires 'name',        type: String, desc: ''
      requires 'description', type: String, desc: ''
    end

    post do
      issue = Issue.new(
        name: params[:name],
        description: params[:description],
        creator_id: current_user.id,
        assignee_id: current_user.regular? ? current_user.id : nil # non regular issues won't be assigned to anyone
      )

      if issue.save
        issue
      else
        error!(issue.errors, 402)
      end
    end
  end
end
