class ChartsController < ApplicationController
  before_action :set_chart, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update]
  # helper method to handle guest or logged in users
  helper_method :current_or_guest_user
  helper_method :font_use

  def waterfallplayground
  end

  def index
    @user = current_user
    @charts = Chart.where(user: @user)
  end

  def create
    @chart = Chart.new
    @chart.user = current_or_guest_user
    # @chart.save
    if @chart.save
      create_3_default_datasets
      respond_to do |format|
        format.html { redirect_to edit_chart_path(@chart)}
        format.js # <-- will render `app/views/charts/create.js.erb`
      end
    # else
    #   respond_to do |format|
    #     format.html { render 'charts/show' }
    #     format.js
    #   end
    end
    # redirect_to edit_chart_path(@chart)
  end

  def createwaterfall
    @chart = Chart.new
    @chart.user = current_or_guest_user
    @chart.chart_type = "waterfall"
    if @chart.save
      create_4_default_waterfall_datasets
      redirect_to edit_waterfall_path(@chart)
    end
  end

  def edit
    @dataset = Dataset.new
  end

  def edit_waterfall
    @dataset = Dataset.new_dataset
  end

  def update
    if @chart.update(chart_params)
      respond_to do |format|
        format.html { redirect_to edit_chart_path(@chart)}
        format.js # <-- will render `app/views/charts/create.js.erb`
      end
    # else ?
    end
  end

  def destroy
    @chart.destroy
    redirect_to charts_path
  end

  def font_use
    return @chart.font_size if show_export?
    return 8
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

  def create_4_default_waterfall_datasets
    labels = ["End of Q1", "Income", "Expenses", "End of Q2"]
    values = [10 , 2 ,  3  , 9 ]
    serietypes = ["basline", "plus", "less", "baseline"]
    offsets = [ 0 , 10 , 9 , 0 ]
    i=0
    4.times do 
      new_dataset = Dataset.new(label: labels[i], value: values[i], serietype: serietypes[i], offset: offsets[i])
      new_dataset.chart = @chart
      new_dataset.savei += 1
    end
  end


  def set_chart
    @chart = Chart.find(params[:id])
  end

  def chart_params
    params.require(:chart).permit(:title, :subtitle, :notes, :color, :font_size)
  end
end
