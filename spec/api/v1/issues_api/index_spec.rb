# frozen_string_literal: true

require 'spec_helper'

RSpec.describe V1::IssuesAPI::Index do
  describe '[GET] /api/v1/issues' do
    let(:endpoint) { '/api/v1/issues' }

    let(:regular_user) { create(:user, :regular) }
    let(:manager) { create(:user, :manager) }
    let!(:regular_user_issues) { create_list(:issue, 3, creator_id: regular_user.id) }
    let!(:manager_issues) { create_list(:issue, 2, creator_id: manager.id) }

    let(:regular_user_auth) { { Authorization: JsonWebToken.encode(user_id: regular_user.id) } }
    let(:manager_auth) { { Authorization: JsonWebToken.encode(user_id: manager.id) } }

    context 'when regular user gets issues list' do
      it 'should return only regular user issues' do
        get(endpoint, params: {}, headers: regular_user_auth)
        expect(status).to eq(200)
        expect(JSON.parse(body).size).to be regular_user_issues.size
      end
    end

    context 'when manager gets issues list' do
      it 'should return only regular user issues' do
        get(endpoint, params: {}, headers: manager_auth)
        expect(status).to eq(200)
        total_issues = regular_user_issues.size + manager_issues.size
        expect(JSON.parse(body).size).to eq(total_issues)
      end
    end

    describe 'sorting by status' do
      it 'should return only specific issues' do
        regular_user_issues.last.in_progress!
        get(endpoint, params: { status: 'in_progress' }, headers: regular_user_auth)
        expect(status).to eq(200)
        expect(JSON.parse(body).size).to be 1
      end
    end
  end
end
