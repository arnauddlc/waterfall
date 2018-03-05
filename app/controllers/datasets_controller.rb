class DatasetsController < ApplicationController
  before_action :set_dataset, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:update, :create]

  def create
    @chart = Chart.find(params[:chart_id])
    @dataset = Dataset.new(dataset_params)
    @dataset.chart = @chart
    if @dataset.save
      respond_to do |format|
        format.html { redirect_to edit_chart_path(@chart)}
        format.js # <-- will render `app/views/datasets/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'charts/edit' }
        format.js
      end
    end
  end

  def edit
    @chart = @dataset.chart
  end

  def update
    if @dataset.update(dataset_params)
      respond_to do |format|
        format.html { redirect_to edit_chart_path(@chart)}
        format.js # <-- will render `app/views/datasets/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'charts/edit' }
        format.js
      end
    end
  end

  def destroy
    @chart = @dataset.chart
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
