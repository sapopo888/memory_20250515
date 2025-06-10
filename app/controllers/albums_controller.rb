class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def index
    @albums = current_user.albums.order(created_at: :desc)
  end

  def new
    @album = current_user.albums.new
  end

  def create
    @album = current_user.albums.new(album_params)
    if @album.save
      redirect_to new_album_photo_path(@album), status: :see_other, notice: t("defaults.flash_message.created", item: Album.model_name.human)
    else
    flash.now[:alert] = t("defaults.flash_message.not_created", item: Album.model_name.human)
    render :new, status: :unprocessable_entity # 作成失敗したエラーメッセージを表示するのに必要
    end
  end

  def show
    @album = current_user.albums.find(params[:id])
    @photos = @album.photos.order(:created_at)
  end

  def edit
    @album = current_user.albums.find(params[:id])
  end

  def update
    @album = current_user.albums.find(params[:id])
    if @album.update(album_params)
      redirect_to album_path(@album), status: :see_other, notice: t("defaults.flash_message.updated", item: Album.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Album.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    album = current_user.albums.find(params[:id])
    album.destroy!
    redirect_to albums_path, notice: t("defaults.flash_message.deleted", item: Album.model_name.human), status: :see_other
  end

  private

  def album_params
    params.require(:album).permit(:title, :description, :cover_template)
  end
end
