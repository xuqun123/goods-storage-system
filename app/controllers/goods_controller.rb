# frozen_string_literal: true

class GoodsController < ApplicationController
  def index
    @goods = Good.order('created_at desc')
  end

  def upload; end

  def report; end

  def csv_upload; end
end
