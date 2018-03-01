class ChartsController < ApplicationController
  def index
  	@charts = Chart.all # Chart.where(user: :current_user)
  end

  def new
  	@chart = Chart.new
  end

  def create
  	@chart = Chart.new(chart_params)
  	@chart.save
  	# something will need to be added to save data_sets as well
  end

  def edit
  	@chart = Chart.find(params[:id])
  end

  def update
  	@chart = Chart.find(params[:id])
  	@chart.update(chart_params)
  	# something will need to be added to save data_sets as well
  end

  def destroy
  	@chart = Chart.find(params[:id])
  	@chart.destroy
  end


	private

	def chart_params
		params.require(:chart).permit(:title, :subtitle, :notes, :color, :font_size)
	end

end
