class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  before_action :authorize_owner!, only: %i[ edit update destroy ]

  # GET /listings or /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1 or /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Current.user.listings.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = Current.user.listings.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy!

    respond_to do |format|
      format.html { redirect_to listings_path, status: :see_other, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def authorize_owner
      if Current.user != @listing.user
        redirect_to root_path, notice: "You are not authorized to view this page"
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.expect(listing: [ :name, :price, images: [] ])
    end
end