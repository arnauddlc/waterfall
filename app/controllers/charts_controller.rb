class ChartsController < ApplicationController
  before_action :set_chart, only: [:edit, :edit_wf, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :new, :create, :edit, :edit_wf, :update]
  # helper method to handle guest or logged in users
  helper_method :current_or_guest_user
  helper_method :font_use
  helper_method :colors_selector


  def waterfallplayground
  end

  def index
    @user = current_user
    @charts = Chart.where(user: @user)
  end

  def create
    @chart = Chart.new
    @chart.chart_type = params[:type]
    @chart.user = current_or_guest_user
    @chart.color = "gray" if @chart.chart_type == "waterfall"
    # @chart.save
    if @chart.save
      if @chart.chart_type == "waterfall"
        create_4_default_waterfall_datasets
        respond_to do |format|
          format.html { redirect_to edit_chart_path(@chart)}
          format.js # <-- will render `app/views/charts/create.js.erb`
        end
      else
        create_3_default_datasets
        respond_to do |format|
          format.html { redirect_to edit_chart_path(@chart)}
          format.js # <-- will render `app/views/charts/create.js.erb`
        end
      end
    # else
    #   respond_to do |format|
    #     format.html { render 'charts/show' }
    #     format.js
    #   end
    end
    # redirect_to edit_chart_path(@chart)
  end

  def edit
    @active_tab = params[:active_tab]
    @dataset = Dataset.new
  end

  def update
    # raise
    if @chart.update(chart_params)
      respond_to do |format|
        format.html { redirect_to edit_chart_path(@chart, active_tab: params[:active_tab])}
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

  def colors_selector
    colors = { yellow: "#FFDB29",
               orange: "#FD7366",
               blue: "#30C2FF",
               purple: "#9E60F8",
               green: "#3EC28F",
               gray: "#141414" }
    return colors
  end

  private

  def create_3_default_datasets
    labels = ["Jan", "Feb", "Mar"]
    values = [3, 1, 5]
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
    serietypes = ["baseline", "plus", "less", "baseline"]
    offsets = [ 0 , 10 , 9 , 0 ]
    values_user = [ "10", "2", "-3", "e"]
    i=0
    4.times do
      new_dataset = Dataset.new(label: labels[i], value: values[i], serietype: serietypes[i], offset: offsets[i], value_user: values_user[i])
      new_dataset.chart = @chart
      new_dataset.save
      i += 1
    end
  end

  def set_chart
    @chart = Chart.find(params[:id])
  end

  def chart_params
    params.require(:chart).permit(:title, :subtitle, :notes, :color, :font_size, :chart_type)
  end
end
