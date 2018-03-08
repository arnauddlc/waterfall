class DatasetsController < ApplicationController
  before_action :set_dataset, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!

  def create
    @chart = Chart.find(params[:chart_id])
    @dataset = Dataset.new(dataset_params)
    @dataset.chart = @chart
    data_save_common
  end

  def edit
    @chart = @dataset.chart
  end

  def update
    @chart = @dataset.chart
    update_common   
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
    params.require(:dataset).permit(:label, :value, :value_user)
  end

  def data_save_common
    @dataset.value = 0 if @chart.chart_type == "waterfall"
    if @dataset.save
      @chart.updated_at = @dataset.updated_at
      update_datasets_waterfall(@chart) if @chart.chart_type == "waterfall"
      @chart.save
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

  def update_common
    @dataset.value = 0 if @chart.chart_type == "waterfall"
    if @dataset.update(dataset_params)
      @chart.updated_at = @dataset.updated_at
      update_datasets_waterfall(@chart) if @chart.chart_type == "waterfall"
      @chart.save
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

  def update_datasets_waterfall(chart)
    datasets_raw = chart.datasets.order(:created_at)
    sum_result = 0
    i = 0
    datasets_raw.each do |dts|
      if i == 0
        dts.value = dts.value_user.to_i
        dts.serietype = "baseline"
        dts.offset = 0
        sum_result += dts.value
        dts.save
        i += 1
      elsif dts.value_user == "e"
        dts.value = sum_result
        dts.offset = 0
        dts.serietype = "baseline"
        dts.save
        i += 1
      elsif dts.value_user.to_i >= 0
        dts.value = dts.value_user.to_i
        dts.serietype = "plus"
        dts.offset = sum_result
        sum_result += dts.value
        dts.save
        i += 1
      else
        dts.value = -dts.value_user.to_i
        dts.serietype = "less"
        dts.offset = sum_result - dts.value
        sum_result += -dts.value
        dts.save
        i += 1
      end
    end
  end

end
