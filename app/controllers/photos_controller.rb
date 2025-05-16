class PhotosController < ApplicationController
  def new
    @album = current_user.album(params[:album_id])
    @photo = @album.photos.new
  end

  def create
    @album = current_user.album(params[:album_id])
    @photo = @album.photos.builds(photo_params)

    if @photo.save
      redirect_to album_path(params[:album_id]), notice = "画像を保存しました"
    else
      flash.now[:alert] = "画像を保存できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:comment, { images: [] } )
  end
end
