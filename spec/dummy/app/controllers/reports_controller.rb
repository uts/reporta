class ReportsController < ApplicationController

  def index
    @report = ProjectReport.new(params[:report])
    render :index
  end

  def create
    @report = ProjectReport.new(params[:report])
    render :index
  end
end
