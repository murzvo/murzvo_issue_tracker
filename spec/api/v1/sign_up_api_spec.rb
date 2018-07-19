# frozen_string_literal: true

require 'spec_helper'

RSpec.describe V1::SignUpAPI do
  let(:params) do
    {
      username: 'ivan',
      password: '123123123',
      password_confirmation: '123123123',
      role: 'regular'
    }
  end

  describe '[POST] /api/v1/sign_up' do
    let(:endpoint) { '/api/v1/sign_up' }
    context 'when params valid' do
      it 'should create user' do
        post endpoint, params: params
        expect(status).to eq(201)
        expect(JSON.parse(response.body)).to include('username' => 'ivan', 'role' => 'regular')
      end
    end

    context 'when user is already exists' do
      let!(:user) { create(:user, :regular, username: 'ivan') }

      it 'should return an error that username is already exists' do
        post endpoint, params: params
        expect(status).to eq(402)
        expect(JSON.parse(response.body)).to include('detail' => 'Username has already been taken')
      end
    end
  end
end
