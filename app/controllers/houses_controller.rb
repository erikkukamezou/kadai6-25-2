class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]
  before_action :set_stations, only: [:show, :edit, :update]

  def index
    @houses =House.all
  end

  def new
    @house = House.new
    2.times{@house.stations.build}
    # @station =NearestStation.new

    # @station =NearestStation.new
    # @house.build_nearest_station
    # @station =@house.stations.build
  end
  def create
    @house = House.new(house_params)
    if @house.save

    # @house = current_user.houses.build(house_params)
    # @house.save
    redirect_to houses_path

   else
     2.times{@house.stations.build}
     render 'new'
   end
  end

  def show
    @stations = @house.stations
    # @stations = @house.nearest_stations
    # @house = House.find(params[:id])
    # @house = NearestStation.find(params[:id])
  end

  def edit
    @house.stations.build
    # @house = House.find(params[:id])
  end

  def destroy
    @house.destroy
    redirect_to houses_path
  end

  def update
    # @house = House.find(params[:id])
    if @house.update(house_params)
      redirect_to houses_path
    else
      @house.stations.build
      render :edit
    end
  end

  private
  def house_params
    params.require(:house).permit(:name, :rent, :address, :age, :content,
    stations_attributes: [:id, :_destroy, :route, :station, :walk, ]
     )
  end
  #

  def set_stations
      @stations = @house.stations
  end

  # def nearest_stations_params
  #
  #   # params.require(:nearest_station).permit(:route, :station, :walk)
  # end

  def set_house
    @house = House.find(params[:id])
  end

end
