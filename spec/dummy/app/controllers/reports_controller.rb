class ReportsController < ApplicationController

  def table
    @report = ProjectReport.new(params[:form])
  end

  def dynamic_table
    @report = ProjectReport.new(params[:form])
  end

  def dynamic_table_with_bootstrap
    @report = ProjectReport.new(params[:form])
  end

  def chart
    @report = AccountChart.new(params[:form])
  end

end
