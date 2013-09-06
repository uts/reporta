class ReportsController < ApplicationController

  def table
    @report = AccountReport.new(params[:form])
  end

  def dynamic_table
    @report = AccountReport.new(params[:form])
  end

  def dynamic_table_with_bootstrap
    @report = AccountReport.new(params[:form])
  end

  def chart
    @report = AccountChart.new(params[:form])
  end

end
