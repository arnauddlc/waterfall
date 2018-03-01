class DatasetsController < ApplicationController
  before_action :set_dataset, only: [:update, :destroy]

  def create
    @chart = Chart.find(params[:chart_id])
    @dataset = Dataset.new(dataset_params)
    @dataset.chart = @chart
    @dataset.save
  end

  def update
    @dataset.update(dataset_params)
  end

  def destroy
    @dataset.destroy
  end

  private

  def set_dataset
    @dataset = Dataset.find(params[:id])
  end

  def dataset_params
    params.require(:dataset).permit(:label, :value)
  end

end
