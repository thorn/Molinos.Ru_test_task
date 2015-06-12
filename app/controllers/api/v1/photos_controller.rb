class Api::V1::PhotosController < Api::BaseController

  before_action :find_photo, only: [:destroy]

  def create
    build_photo
    save_photo || render_errors
  end

  def destroy
    delete_photo || render_errors
  end

    private

    def find_photo
      @photo = Photo.find(params[:id])
    end

    def delete_photo
      @photo.destroy
    end

    def render_errors
      errors = @photo.errors.any? ? @photo.errors : [ "unknown error" ]
      render json: { errors: errors }.to_json, status: :unprocessable_entity
    end

    def build_photo
      @photo = Photo.new(photo_params)
    end

    def save_photo
      @photo.save
    end

    def photo_params
      params.require(:photo).permit(:image, :item_id)
    end
end
