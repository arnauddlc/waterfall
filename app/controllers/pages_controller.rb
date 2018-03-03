class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def chart_test
  	@datasets = Chart.find(2).datasets.to_json
  end
end
