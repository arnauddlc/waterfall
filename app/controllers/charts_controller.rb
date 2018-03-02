class ChartsController < ApplicationController
  before_action :set_chart, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :new, :edit, :create]
  # helper method to handle guest or logged in users
  helper_method :current_or_guest_user

  def index
    @user = current_user
    @charts = Chart.where(user: @user)
  end

  def new
    @chart = Chart.new
  end

  def create
    @chart = Chart.new(chart_params)
    @chart.user = current_or_guest_user
    @chart.save
    create_3_default_datasets
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
    redirect_to charts_path
  end

  private

  def create_3_default_datasets
    labels = ["Jan", "Feb", "Mar"]
    values = [10, 12, 8]
    i = 0
    3.times do
      new_dataset = Dataset.new(label: labels[i], value: values[i])
      new_dataset.chart = @chart
      new_dataset.save
      i += 1
    end
  end

  def set_chart
    @chart = Chart.find(params[:id])
  end

  def chart_params
    params.require(:chart).permit(:title, :subtitle, :notes, :color, :font_size)
  end

end
