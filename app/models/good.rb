# frozen_string_literal: true

class Good < ApplicationRecord
  validates :consignment_id, :name, :good_type, :source, presence: true
  validates :consignment_id, uniqueness: true

  before_create :set_entry_date

  private

  def set_entry_date
    self.entry_date = Time.now unless entry_date
  end
end
