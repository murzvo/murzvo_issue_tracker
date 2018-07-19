# frozen_string_literal: true

class V1::IssuesAPI::Create < Grape::API
  resource :issues do
    desc 'Service to create an issue' do
      detail 'It is unable to assign issue on create now. Issue will be created as unassigned.
              Use assign endpoint to assign user to the issue'
      headers Authorization: {
        description: 'User auth token',
        required: true
      }
    end

    params do
      requires :name,        type: String
      requires :description, type: String
    end

    post do
      issue = Issue.new(
        name: params[:name],
        description: params[:description],
        creator_id: current_user.id
      )

      if issue.save
        issue
      else
        error!(issue.errors, 402)
      end
    end
  end
end
