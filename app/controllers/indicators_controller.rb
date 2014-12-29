class IndicatorsController < ApplicationController
  before_action :set_indicator, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @indicators = Indicator.all
    respond_with(@indicators)
  end

  def show
    respond_with(@indicator)
  end

  def new
    @indicator = Indicator.new
    respond_with(@indicator)
  end

  def edit
  end

  def create
    @indicator = Indicator.new(indicator_params)
    @indicator.save
    respond_with(@indicator)
  end

  def update
    @indicator.update(indicator_params)
    respond_with(@indicator)
  end

  def destroy
    @indicator.destroy
    respond_with(@indicator)
  end

  private
    def set_indicator
      @indicator = Indicator.find(params[:id])
    end

    def indicator_params
      params.require(:indicator).permit(:id, :name, :category)
    end
end
