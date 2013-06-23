class ReportsController < ApplicationController

  def index
    @report = ProjectReport.new(params[:form])
    render :index
  end

end
