# frozen_string_literal: true

require 'spec_helper'

RSpec.describe V1::IssuesAPI::Unassign do
  describe '[PUT] /api/v1/issues/:id/unassign' do
    let(:endpoint) { "/api/v1/issues/#{issue.id}/unassign" }
    let(:user_auth) { { Authorization: JsonWebToken.encode(user_id: user.id) } }

    before { put(endpoint, headers: user_auth) }

    context 'when issue is assigned to the same user' do
      let(:user) { create(:user) }
      let(:issue) { create(:issue, creator_id: user.id, assignee_id: user.id) }

      it 'should unassign user' do
        expect(status).to eq(200)
        expect(JSON.parse(body)).to include('assignee' => nil)
      end
    end

    context 'when issue is assigne to other user' do
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }
      let(:issue) { create(:issue, creator_id: user.id, assignee_id: another_user.id) }

      it 'should return error' do
        expect(status).to eq(402)
        expect(JSON.parse(body)).to eq([{ "detail" => "Issue can not be unassigned from this user" }])
      end
    end

    context 'when issue is already unassigned' do
      let(:user) { create(:user) }
      let(:issue) { create(:issue, creator_id: user.id) }

      it 'should return error' do
        expect(status).to eq(402)
        expect(JSON.parse(body)).to eq([{ "detail" => "Issue is already unassigned" }])
      end
    end

    context 'when issue is in unassignable statuses' do
      let(:user) { create(:user) }
      let(:issue) { create(:issue, creator_id: user.id, assignee_id: user.id, status: issue_status) }

      context 'when in_progress' do
        let(:issue_status) { :in_progress }

        it 'should return error' do
          expect(status).to eq(402)
          expect(JSON.parse(body)).to eq([{ "detail" => "Issue with status In progress can not be unassigned" }])
        end
      end

      context 'when in_progress' do
        let(:issue_status) { :resolved }

        it 'should return error' do
          expect(status).to eq(402)
          expect(JSON.parse(body)).to eq([{ "detail" => "Issue with status Resolved can not be unassigned" }])
        end
      end
    end
  end
end
