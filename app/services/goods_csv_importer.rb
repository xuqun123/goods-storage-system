# frozen_string_literal: true

require 'csv'

# A goods bulk upload service reading data from a csv file
module GoodsCsvImporter
  HEADERS = %w[consignment_id name good_type source destination entry_date exit_date].freeze

  def self.import(file)
    results = { success: [], error: [] }

    CSV.foreach(file.path, headers: true) do |row|
      result = upsert(row)
      results[result.keys.first] << result.values.first
    end
    results
  end

  def self.upsert(data)
    good_attributes = data.to_h.with_indifferent_access
    consignment_id = good_attributes['consignment_id']

    good = Good.find_or_initialize_by(consignment_id: consignment_id)
    good.attributes = good_attributes

    if good.new_record? && good_attributes['exit_date'].present?
      return { error:
      "[#{consignment_id}] exit date is not required while registering this good." }
    end

    if good.save
      { success: "[#{consignment_id}] upload successfully." }
    else
      { error: "[#{consignment_id}] #{good.errors.full_messages.join(', ')}." }
    end
  end

  def self.generate_sample_csv(goods)
    CSV.generate(headers: true) do |csv|
      csv << HEADERS

      goods.each do |good|
        csv << HEADERS.map do |attr|
          if %w[exit_date entry_date].include?(attr)
            good.send(attr)&.strftime('%d/%m/%Y %H:%M')
          else
            good.send(attr)
          end
        end
      end
    end
  end
end
