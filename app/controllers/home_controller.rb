class HomeController < ApplicationController
  def index
    @result = client.fetch_issue(params[:id] || 1)
  end

  def client
    @_client ||= APIClient.new
  end
end
