class AlbumsController < ApplicationController
  def index
    @albums = current_user.albums.order(created_at: :desc)
  end

  def new
    @album = current_user.albums.new
  end

  def create
    @album = current_user.albums.new(album_params)
    if @album.save
      redirect_to new_album_photo_path(@album), status: :see_other, notice: "アルバムを作成しました"
    else
    flash.now[:alert] = "アルバムを作成できませんでした"
    render :new, status: :unprocessable_entity # 作成失敗したエラーメッセージを表示するのに必要
    end
  end

  def show
    @album = current_user.albums.find(params[:id])
    @photos = @album.photos
  end

  def destroy
    album = current_user.albums.find(params[:id])
    album.destroy!
    redirect_to albums_path, notice: t("defaults.flash_message.deleted", item: Album.model_name.human), status: :see_other
  end

  private

  def album_params
    params.require(:album).permit(:title, :description)
  end
end
