# frozen_string_literal: true

FactoryBot.define do
  factory :good do
    consignment_id { 'AS1001AP' }
    name { 'Coconuts' }
    good_type { 'Food' }
    source { 'Australia/Sydney' }
    destination { 'Australia/Perth' }
    entry_date { '11/01/2019 18:53' }
    exit_date { '12/01/2019 18:53' }
  end
end
