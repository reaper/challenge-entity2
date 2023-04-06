class BookingsController < ApplicationController
  before_action :set_listing
  before_action :set_booking, only: %i[ show edit update destroy cancel ]

  # GET /bookings or /bookings.json
  def index
    @bookings = @listing.bookings
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = @listing.bookings.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    @booking = @listing.bookings.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to listing_url(@listing), notice: "Booking was successfully created." }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to listing_url(@listing), notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to listing_url(@listing), notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def cancel
    @booking.cancel!

    respond_to do |format|
      format.html { redirect_to listing_path(@listing), notice: "Booking was successfully canceled." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = @listing.bookings.find(params[:id])
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:start_date, :end_date)
    end
end
