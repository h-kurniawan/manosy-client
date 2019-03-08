class HomeController < ApplicationController
  def index
    @result = APIClient.new.smoke_test
  end
end
