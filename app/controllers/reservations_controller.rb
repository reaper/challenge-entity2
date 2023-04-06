class ReservationsController < ApplicationController
  before_action :set_listing
  before_action :set_reservation, only: %i[ show edit update destroy cancel ]

  # GET /reservations or /reservations.json
  def index
    @reservations = @listing.reservations.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = @listing.reservations.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = @listing.reservations.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to listing_url(@listing), notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to listing_url(@listing), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to listing_url(@listing), notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def cancel
    @reservation.cancel!

    respond_to do |format|
      format.html { redirect_to listing_path(@listing), notice: "Reservation was successfully canceled." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = @listing.reservations.find(params[:id])
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date)
    end
end
