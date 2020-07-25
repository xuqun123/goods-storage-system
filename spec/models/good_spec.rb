# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Good, type: :model do
  it { is_expected.to validate_presence_of :consignment_id }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :good_type }
  it { is_expected.to validate_presence_of :source }
  it { is_expected.to validate_uniqueness_of :consignment_id }

  describe '#set_entry_date' do
    subject { good.entry_date }
    let(:current_time) { Time.new(2020, 7, 25) }
    let(:good) { build(:good, entry_date: entry_date) }

    before do
      allow(Time).to receive(:now) { current_time }
      good.save
    end

    context 'when entry_date is provided' do
      let(:entry_date) { Time.new(2020, 1, 1) }

      it { is_expected.to eq entry_date }
    end

    context 'when entry_date is not provided' do
      let(:entry_date) { nil }

      it { is_expected.to eq current_time }
    end
  end
end
