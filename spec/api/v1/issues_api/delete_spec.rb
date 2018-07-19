# frozen_string_literal: true

require 'spec_helper'

RSpec.describe V1::IssuesAPI::Delete do
  describe '[DELETE] /api/v1/issues/:id' do
    let(:endpoint) { "/api/v1/issues/#{issue.id}" }
    let(:user) { create(:user) }
    let(:user_auth) { { Authorization: JsonWebToken.encode(user_id: user.id) } }

    before { delete(endpoint, headers: user_auth) }

    context 'when user deletes own issue' do
      let(:issue) { create(:issue, creator_id: user.id) }

      it 'should delete an issue' do
        expect(status).to eq(200)
        expect(JSON.parse(body)).to include('id' => issue.id)
      end
    end

    context 'when user deletes an issue, created by other user' do
      let(:other_user) { create(:user) }
      let(:issue) { create(:issue, creator_id: other_user.id) }

      it 'should return error' do
        expect(status).to eq(403)
        expect(JSON.parse(body)).to eq([{ 'detail' => 'You have not enough rights to proceed this action' }])
      end
    end
  end
end
