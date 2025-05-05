# app/controllers/pictures_controller.rb
require 'csv'

class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy, :export]

  # GET /pictures
  # HTML only
  def index
    @pictures = Picture.all
  end

  # GET /pictures/export_all.csv
  # Streams a CSV of all pictures when the user clicks “Generate CSV”
  def export_all
    csv_data = generate_csv(Picture.all)

    send_data csv_data,
              filename: "pictures-#{Date.today}.csv",
              type: "text/csv; charset=utf-8"
  end

  # GET /pictures/:id/export.csv
  # Streams a CSV for a single picture
  def export
    csv_data = generate_csv([@picture])

    send_data csv_data,
              filename: "picture-#{@picture.id}-#{Date.today}.csv",
              type: "text/csv; charset=utf-8"
  end

  # GET /pictures/:id
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # POST /pictures
  def create
    @picture = Picture.new(picture_params)

    if @picture.save
      redirect_to @picture, notice: 'Picture was successfully created.'
    else
      render :new
    end
  end

  # GET /pictures/:id/edit
  def edit
  end

  # PATCH/PUT /pictures/:id
  def update
    if @picture.update(picture_params)
      redirect_to @picture, notice: 'Picture was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pictures/:id
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: 'Picture was successfully destroyed.'
  end

  private

  # DRY CSV generation for any set of pictures
  def generate_csv(pictures)
    CSV.generate(headers: true) do |csv|
      csv << %w[id title created_at]
      pictures.find_each do |pic|
        csv << [pic.id, pic.title, pic.created_at]
      end
    end
  end

  # Load @picture for member actions
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Strong parameters
  def picture_params
    params.require(:picture).permit(:title)
  end
end
