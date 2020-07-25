# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserSessions', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/login'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /login' do
    subject { post '/login', params: params }
    let(:password) { 'user_password' }
    let(:user) { create(:user, password: password) }

    context 'when email is not found' do
      let(:params) { { email: 'not_found@examle.com' } }

      it 'redirects to login' do
        expect(subject).to redirect_to(login_url)
      end
    end

    context 'when password is not valid' do
      let(:params) { { email: user.email, password: 'random password' } }

      it 'redirects to login' do
        expect(subject).to redirect_to(login_url)
      end
    end

    context 'when credential is valid' do
      let(:params) { { email: user.email, password: password } }

      it 'redirects to root page' do
        expect(subject).to redirect_to(root_url)
        expect(session[:user_id]).to eq user.id
      end
    end
  end

  describe 'DELETE /logout' do
    let(:password) { 'user_password' }
    let(:user) { create(:user, password: password) }
    let(:params) { { email: user.email, password: password } }

    before { post '/login', params: params }

    it 'clears user session and redirects to login' do
      expect(session[:user_id]).to eq user.id

      delete '/logout'
      expect(response).to redirect_to(login_url)
      expect(session[:user_id]).to be_nil
    end
  end
end
