class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:buy]
  # GET /listings or /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1 or /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    authorize @listing
  end

  # GET /listings/1/edit
  def edit
    #Pundit access
    authorize @listing
  end

  # POST /listings or /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    #Pundit access
    authorize @listing
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
    #Pundit access
    authorize @listing
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
    #Pundit access
    authorize @listing
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #GET /listings/view/1
  def show_users
    user = User.find(params[:id])
    @grandma = user
    @listings = Listing.where(user_id: user.id)
  end

  #POST /create-checkout-session
  def buy
    Stripe.api_key = ENV["STRIPE_API_KEY"]
    listing = Listing.find(params[:id])
    session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "aud",
          product_data: {
            name: listing.name,
          },
          unit_amount: listing.return_price,
        },
        quantity: 1,
      }],
      mode: "payment",
      # These placeholder URLs will be replaced in a following step.
      success_url: "#{request.base_url}/success/#{current_user.id}/#{listing.id}",
      cancel_url: "#{request.base_url}/cancel",
    })
    render json: session
  end

  #GET /success/:userid/:listingid
  def purchased
    user = User.find(params[:uid])
    listing = Listing.find(params[:lid])
    Order.create(user: user, listing: listing)
    redirect_to orders_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def listing_params
    params.require(:listing).permit(:name, :price, :description, :ingredients, :user_id, :photo)
  end
end
