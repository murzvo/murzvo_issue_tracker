# frozen_string_literal: true

require 'spec_helper'

RSpec.describe V1::IssuesAPI::Create do
  describe '[PUT] /api/v1/issues/:id/assign' do
    let(:endpoint) { "/api/v1/issues" }
    let(:user) { create(:user) }
    let(:user_auth) { { Authorization: JsonWebToken.encode(user_id: user.id) } }
    let(:params) do
      {
        name: 'Create API V2',
        description: 'API V1 is okay, but we want V2'
      }
    end

    context 'when params are valid' do
      it 'should create an issue' do
        post(endpoint, params: params, headers: user_auth)
        expect(status).to eq(201)
        expect(JSON.parse(body)).to include('name' => 'Create API V2')
      end
    end
  end
end
