# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to validate_presence_of :password_hash }

  describe '#valid?' do
    subject { user.valid? }
    let(:user) { build(:user, email: email) }

    context 'when email is valid' do
      let(:email) { 'valid@example.com' }

      it { is_expected.to be true }
    end

    context 'when email is invalid' do
      let(:email) { 'invalid@' }
      it { is_expected.to be false }
    end
  end

  describe '#password' do
    subject { user.password }

    let(:password_hash) { '$2a$12U51' }
    let(:user) { User.new(password_hash: password_hash) }

    before { allow(BCrypt::Password).to receive(:new).with(password_hash) { password_hash } }

    it { is_expected.to eq password_hash }
  end

  describe '#password=' do
    subject { user }

    let(:user) { User.new }
    let(:new_password) { 'new password' }
    let(:password_hash) { '$2a$12U51' }

    before do
      allow(BCrypt::Password).to receive(:create).with(new_password) { password_hash }
      user.password = new_password
    end

    it 'should generate a password hash based on the new password' do
      expect(subject.password).to eq password_hash
      expect(subject.password_hash).to eq password_hash
    end
  end

  describe '#authenticate' do
    subject { user.authenticate(given_password) }

    let(:password) { 'user password' }
    let(:user) { create(:user, password: password) }

    context 'when password is invalid' do
      let(:given_password) { 'invalid password' }
      it { is_expected.to be false }
    end

    context 'when password is invalid' do
      let(:given_password) { password }
      it { is_expected.to be true }
    end
  end
end
