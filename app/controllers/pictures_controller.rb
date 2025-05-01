class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]

  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all

    respond_to do |format|
      format.html
      format.json {render json: @pictures}
    end
  end

  # GET /pictures/1 or /pictures/1.json
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html
      format.json {render json: @picture}
    end
  end

  # GET /pictures/new
  def new
    @picture = Picture.new

    respond_to do |format|
      format.html
      format.json {render json: @picture}
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures or /pictures.json
  def create
    ## carrierwave as single
     @picture = Picture.new(params[:picture])

      if @picture.save
       flash[:notice] = "Successfully created picture."
      redirect_to @picture
   else
   render :action => 'new'

   @picture = Picture.new(:title => params[:file])
   @picture.save!
   render :nothing => true
 end
  end

  # PATCH/PUT /pictures/1 or /pictures/1.json
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to @picture, notice: 'picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1 or /pictures/1.json
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy!

    respond_to do |format|
      format.html { redirect_to pictures_url }
      format.json { head :no_content }
    end
  end
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.expect(picture: [ :title ])
    end
end
