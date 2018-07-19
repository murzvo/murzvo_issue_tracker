# frozen_string_literal: true

require 'spec_helper'

RSpec.describe V1::IssuesAPI::Assign do
  describe '[PUT] /api/v1/issues/:id/assign' do
    let(:endpoint) { "/api/v1/issues/#{issue.id}/assign" }
    let(:user_auth) { { Authorization: JsonWebToken.encode(user_id: user.id) } }
    let(:assignee_structure) do
      {
        "id" => user.id,
        "username" => user.username,
        "role" => user.role
      }
    end

    before { put(endpoint, params: { assignee_id: user.id }, headers: user_auth) }

    context 'when issue is unassigned' do
      let(:user) { create(:user) }
      let(:issue) { create(:issue, creator_id: user.id) }

      it 'should assign user' do
        expect(status).to eq(200)
        expect(JSON.parse(body)).to include('assignee' => assignee_structure)
      end
    end

    context 'when issue is already assigned' do
      let(:user) { create(:user) }
      let(:issue) { create(:issue, creator_id: user.id, assignee_id: user.id) }

      it 'should return error' do
        expect(status).to eq(402)
        expect(JSON.parse(body)).to eq([{ "detail" => "Issue is already assigned" }])
      end
    end

    context 'when user tries to assign not own issue' do
      let(:other_user) { create(:user, :regular) }
      let(:issue) { create(:issue, creator_id: other_user.id) }

      context 'when regular user' do
        let(:user) { create(:user, :regular) }

        it 'should return error' do
          expect(status).to eq(402)
          expect(JSON.parse(body)).to eq([{ "detail" => "Issue can not be assigned to this user" }])
        end
      end

      context 'when manager' do
        let(:user) { create(:user, :manager) }

        it 'should return error' do
          expect(status).to eq(402)
          expect(JSON.parse(body)).to eq([{ "detail" => "Issue can not be assigned to this user" }])
        end
      end
    end
  end
end
