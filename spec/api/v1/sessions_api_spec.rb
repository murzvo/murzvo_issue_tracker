# frozen_string_literal: true

require 'spec_helper'

RSpec.describe V1::SessionAPI do
  let(:params) do
    {
      username: 'ivan',
      password: '123123123'
    }
  end

  describe '[POST] /api/v1/session' do
    let(:endpoint) { '/api/v1/session' }
    let!(:user) { create :user, username: 'ivan', password: '123123123', password_confirmation: '123123123' }

    context 'when params valid' do
      it 'should create JWT token' do
        post endpoint, params: params
        expect(status).to eq(201)
        expect(JSON.parse(response.body)).to include('token')
      end
    end

    context 'when params invalid' do
      it 'should return an error' do
        post endpoint, params: { username: 'igor', password: '123123123' }
        expect(status).to eq(401)
        expect(JSON.parse(response.body)).to include('detail' => 'Incorrect username or password')
      end
    end

    context 'when params blank' do
      it 'should return params missing errors' do
        post endpoint, params: {}
        expect(status).to eq(400)
        body = JSON.parse(response.body)
        expect(body).to include('detail' => 'username is missing')
        expect(body).to include('detail' => 'password is missing')
      end
    end
  end
end
