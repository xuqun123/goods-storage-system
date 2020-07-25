# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoodsCsvImporter do
  describe '.upsert' do
    subject { described_class.send(:upsert, data) }

    context 'when inserts a new good' do
      context 'with valid data' do
        let(:data) { attributes_for(:good, exit_date: nil) }

        it 'should create the good successfully' do
          expect { subject }.to change { Good.count }.by(1)
        end
      end

      context 'with invalid data' do
        let(:data) { attributes_for(:good, exit_date: Time.new(2020, 12, 1)) }

        it 'should return an error message' do
          expect(subject.dig(:error)).to be_present
        end
      end
    end

    context 'when update an existing good' do
      let(:consignment_id) { 'AS1001AP' }
      let!(:good) { create(:good, consignment_id: consignment_id, exit_date: nil) }

      context 'with valid data' do
        let(:exit_date) { Time.new(2020, 10, 2) }
        let(:data) { { consignment_id: consignment_id, name: 'new name', exit_date: exit_date } }

        it 'should update the good successfully' do
          expect(subject.dig(:success)).to be_present

          good.reload
          expect(good.exit_date).to eq exit_date
        end
      end

      context 'with invalid data' do
        let(:data) { { consignment_id: consignment_id, name: '' } }

        it 'should return an error message' do
          expect(subject.dig(:error)).to be_present
        end
      end
    end
  end

  describe '.import' do
    subject { described_class.import(File.open(Rails.root.join('spec', 'fixtures', 'test_goods_import.csv'))) }

    let(:consignment_id) { 'AS1001AP' }
    let!(:good) { create(:good, consignment_id: consignment_id) }
    let(:error_data) do
      [
        '[AS1002AP] exit date is not required while registering this good',
        '[AS1003AP] exit date is not required while registering this good'
      ]
    end
    let(:success_data) do
      [
        '[AS1001AP] upload successfully',
        '[AS1004AP] upload successfully'
      ]
    end

    it 'should import valid goods and return errors for invalid goods' do
      expect(Good.count).to eq 1

      expect(subject).to eq({ error: error_data, success: success_data })
      expect(Good.count).to eq 2
    end
  end
end
