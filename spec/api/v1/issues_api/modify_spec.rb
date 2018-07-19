# frozen_string_literal: true

require 'spec_helper'

RSpec.describe V1::IssuesAPI::Modify do
  describe '[PUT] /api/v1/issues/:id' do
    let(:endpoint) { "/api/v1/issues/#{issue.id}" }
    let(:user) { create(:user) }
    let(:user_auth) { { Authorization: JsonWebToken.encode(user_id: user.id) } }

    context 'when user updates own issue' do
      let(:issue) { create(:issue, creator_id: user.id) }

      it 'should update an issue' do
        put(endpoint, params: { name: 'Provide beatiful UI' }, headers: user_auth)
        expect(status).to eq(200)
        expect(JSON.parse(body)).to include('name' => 'Provide beatiful UI')
      end
    end

    context 'when user updates issue created by other user' do
      let(:other_user) { create(:user) }
      let(:issue) { create(:issue, creator_id: other_user.id) }

      it 'should return error' do
        put(endpoint, params: { name: 'Provide beatiful UI' }, headers: user_auth)
        expect(status).to eq(403)
        eq([{ 'detail' => 'You have not enough rights to proceed this action' }])
      end
    end

    context 'when user wants to update status of in progress issue' do
      let(:issue) { create(:issue, creator_id: user.id, status: :in_progress) }

      it 'should return error' do
        put(endpoint, params: { status: :pending }, headers: user_auth)
        expect(status).to eq(402)
        eq([{ 'detail' => 'You can not change status of this issue' }])
      end
    end
  end
end
