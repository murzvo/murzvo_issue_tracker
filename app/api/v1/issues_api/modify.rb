# frozen_string_literal: true

class V1::IssuesAPI::Modify < Grape::API
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
    end

    put ':id', requirements: { id: /[0-9]+/ } do
      issue = Issue.find(params[:id])
      issue.update(
        name: params[:name],
        description: params[:description]
      )
      issue.as_json(only: %i[id name description assignee_id creator_id created_at])
    end
  end
end
