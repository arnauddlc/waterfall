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
    @chart.chart_type == "waterfall" ? update_waterfall : update_non_waterfall    
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
    if @dataset.save
      @chart.updated_at = @dataset.updated_at
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

  def update_non_waterfall
    if @dataset.update(dataset_params)
      @chart = @dataset.chart
      @chart.updated_at = @dataset.updated_at
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

  def update_waterfall
    @dataset.value = 0
    @dataset.update(dataset_params)
    @chart = @dataset.chart
    @chart.updated_at = @dataset.updated_at
    datasets_raw = @chart.datasets
    sum_result = 0
    i = 0
    datasets_raw.each do |dataset|
      if i == 0
        dataset.value = value_user.to_i
        dataset.serietype = "baseline"
        dataset.offset = 0
        sum_result += dataset.value
        dataset.save
        i += 1
      elsif dataset.value_user == "e"
        dataset.value = sum_result
        dataset.offset = 0
        dataset.serietype = "baseline"
        dataset.save
        i += 1
      elsif dataset.value_user.to_i >= 0
        dataset.value = dataset.value_user.to_i
        dataset.serietype = "plus"
        dataset.offset = sum_result
        sum_result += dataset.value
        dataset.save
        i += 1
      elsif dataset.value_user.to_i < 0
        dataset.value = -dataset.value_user.to_i
        dataset.serietype = "less"
        dataset.offset = sum_result - dataset.value
        sum_result += -dataset.value
        dataset.save
        i += 1
      else
        respond_to do |format|
        format.html { render 'charts/edit' }
        format.js
        end
      end
    end
    @chart.save
    respond_to do |format|
      format.html { redirect_to edit_chart_path(@chart)}
      format.js # <-- will render `app/views/datasets/create.js.erb`
    end
  end

end
