class ReportsController < ApplicationController

  def table
    @report = ProjectReport.new(params[:form])
  end

  def dynamic_table
    @report = ProjectReport.new(params[:form])
  end

end
