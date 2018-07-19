# frozen_string_literal: true

require 'spec_helper'

RSpec.describe V1::IssuesAPI::Show do
  let(:endpoint) { "/api/v1/issues/#{issue.id}" }
  let(:user_auth) { { Authorization: JsonWebToken.encode(user_id: user.id) } }
  let(:issue) { create(:issue, creator_id: user.id) }

  describe '[GET] /api/v1/issues/:id' do
    let(:user) { create(:user, :regular) }

    it 'should return issue data' do
      get(endpoint, headers: user_auth)
      expect(status).to eq(200)
      expect(JSON.parse(body)).to include('id' => issue.id)
    end
  end

  describe 'validations' do
    let(:error_message) { [{ 'detail' => 'You have not enough rights to proceed this action' }] }

    before { get(endpoint, headers: user_auth) }

    context 'when user is manager' do
      let(:user) { create(:user, :manager) }
      it 'should return an issue' do
        expect(status).to eq(200)
        expect(JSON.parse(body)).to include('id' => issue.id)
      end
    end

    context 'when user is regular' do
      let(:user) { create(:user, :regular) }
      let(:manager) { create(:user, :manager) }

      context 'when issue is created by regular user' do
        let(:issue) { create(:issue, creator_id: user.id) }

        it 'should return an issue' do
          expect(status).to eq(200)
          expect(JSON.parse(body)).to include('id' => issue.id)
        end
      end

      context 'when issue is assigned to user' do
        let(:issue) { create(:issue, creator_id: manager.id, assignee_id: user.id) }

        it 'should return an issue' do
          expect(status).to eq(200)
          expect(JSON.parse(body)).to include('id' => issue.id)
        end
      end

      context 'when issue is created by manager' do
        let(:issue) { create(:issue, creator_id: manager.id) }

        it 'should return an error' do
          expect(status).to eq(403)
          expect(JSON.parse(body)).to eq(error_message)
        end
      end
    end
  end
end
