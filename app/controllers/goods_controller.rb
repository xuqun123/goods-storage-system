# frozen_string_literal: true

class GoodsController < ApplicationController
  def index
    @goods = Good.order('created_at desc')
  end

  def upload; end

  def report; end

  def sample_csv
    @goods = Good.order('created_at desc').limit(5)

    respond_to do |format|
      format.csv { send_data GoodsCsvImporter.generate_sample_csv(@goods), filename: "sample-goods-#{Date.today}.csv" }
    end
  end

  def csv_upload
    @results = GoodsCsvImporter.import(params[:file])

    respond_to do |format|
      format.js
      format.json { render json: { results: @results } }
      format.html do
        flash[:results] = @results
        redirect_to upload_goods_url
      end
    end
  end
end
