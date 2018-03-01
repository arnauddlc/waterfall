class ChartsController < ApplicationController
	before_action :set_chart, only: [:edit, :update, :destroy]

  def index
  	@charts = Chart.all # Chart.where(user: :current_user)
  end

  def new
  	@chart = Chart.new
  end

  def create
  	@chart = Chart.new(chart_params)
    @chart.user = current_user
  	@chart.save
  	# something will need to be added to save data_sets as well
    redirect_to edit_chart_path(@chart)
  end

  def edit
    @dataset = Dataset.new
  end

  def update
  	@chart.update(chart_params)
  	# something will need to be added to save data_sets as well
  end

  def destroy
  	@chart.destroy
  end

	private

	def set_chart
		@chart = Chart.find(params[:id])
	end

	def chart_params
		params.require(:chart).permit(:title, :subtitle, :notes, :color, :font_size)
	end

end
