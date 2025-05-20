class PhotosController < ApplicationController
  def new
    @album = current_user.albums.find(params[:album_id])
    @photo = current_user.photos.new
  end

  def create
    @album = current_user.albums.find(params[:album_id])
    uploaded_images = params[:images] || []
    comments = params[:comments] || []

    existing_hashes = @album.photos.pluck(:image_hashes).flatten.uniq
    new_hashes = []
    new_photos = []

    # 画像とコメントをペアにして処理
    uploaded_images.zip(comments).each do |image, comment|
      image_hash = Photo.generate_image_hash(image)

      # すでにDBにある、または今回のアップロード内で重複している画像をスキップ
      next if existing_hashes.include?(image_hash) || new_hashes.include?(image_hash)

      photo = current_user.photos.new(
        comment: comment.presence || "",
        album: @album
      )
      photo.images = [ image ]
      photo.image_hashes = [ image_hash ]

      new_photos << photo
      new_hashes << image_hash
    end

    # 保存処理
    saved_photos = new_photos.select(&:save)

    case saved_photos.size
    when uploaded_images.size     # 全て新規登録
      redirect_to album_path(@album), notice: t("photos.new.added_images"), status: :see_other
    when 0                        # 全て重複
      flash.now[:alert] = t("photos.new.all_rejected")
      render :new, status: :unprocessable_entity
    else                          # 一部登録、一部重複
      redirect_to album_path(@album), notice: t("photos.new.added_some_images")
    end
  end

  def edit_multiple
    @album = current_user.albums.find(params[:album_id])
    @photos = @album.photos.order(:created_at)
  end

  def update_multiple
    @album = current_user.albums.find(params[:album_id])
    @photos = @album.photos.order(:created_at)

    update_success = true

    params[:photos].each do |index, photo_params|
      photo = @album.photos.find(photo_params[:id])
      unless photo.update(comment: photo_params[:comment])
        update_success = false
      end
    end

    if update_success
      redirect_to album_path(@album), notice: "画像のコメントを更新しました", status: :see_other
    else
      flash.now[:alert] = "画像のコメント絵を更新できませんでした"
      render :edit_multiple, status: :unprocessable_entity
    end
  end

  def destroy
    @album = current_user.albums.find(params[:album_id])
    @photo = @album.photos.find(params[:id])

    @photo.destroy!
    redirect_to album_edit_photos_path(@album), notice: "画像を削除しました"
  end

  private

  def photo_params
    params.require(:photo).permit(:comment, { images: [] }, :image_cache)
  end
end
