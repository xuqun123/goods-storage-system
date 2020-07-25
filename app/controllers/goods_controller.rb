# frozen_string_literal: true

class GoodsController < ApplicationController
  def index
    @goods = Good.order('created_at desc')
  end

  def upload; end

  def report
    @goods = Good.where('created_at >=?', 1.week.ago).order('created_at desc')
    @categories = @goods.map(&:good_type).uniq

    @series = [
      { name: 'Goods In', data: @categories.map do |category|
                                  @goods.where(good_type: category).where('entry_date >=?', 1.week.ago).count
                                end                               },
      { name: 'Goods In', data: @categories.map do |category|
                                  @goods.where(good_type: category).where('exit_date >=?', 1.week.ago).count
                                end                               }
    ]
  end

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
