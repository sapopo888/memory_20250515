class PhotosController < ApplicationController
  def new
    @album = current_user.albums.find(params[:album_id])
    @photo = current_user.photos.new
  end

  def create
    @album = current_user.albums.find(params[:album_id])
    @photo = current_user.photos.new(photo_params)
    @photo.album = @album # 関連を設定

    if @photo.save
      redirect_to album_path(@album), status: :see_other, notice: "画像を保存しました"
    else
      flash.now[:alert] = "画像を保存できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @album = current_user.albums.find(params[:album_id])
    @photos = @album.photos
  end

  private

  def photo_params
    params.require(:photo).permit(:comment, { images: [] }, :image_cache )
  end
end
