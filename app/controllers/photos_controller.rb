class PhotosController < ApplicationController
  def new
    @album = current_user.albums.find(params[:album_id])
    @photo = current_user.photos.new
  end

  # def create
  #   @album = current_user.albums.find(params[:album_id])
  #   uploaded_images = params[:images] || []
  #   comments = params[:comments] || []
  #   if uploaded_images.any?
  #     uploaded_images.each_with_index do |image, i|
  #       comment = comments[i] || "" # 画像に対応するコメントを取り出す。もしコメントが送られていなければ、空の文字列""を使う
  #       photo = current_user.photos.new(comment: comment, album: @album) # photoの新しいデータを作る。コメントを設定してアルバムと紐付ける。
  #       photo.images = [ image ] # CarrierWaveが画像を配列で受け取れるように、画像を配列の形にする
  #       photo.save
  #     end

  #     redirect_to album_path(@album), notice: t("defaults.flash_message.save_images"), status: :see_other
  #   else
  #     flash.now[:alert] = t("defaults.flash_message.no_choice")
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # def create
  #   @album = current_user.albums.find(params[:album_id])
  #   uploaded_images = params[:images] || []
  #   comments = params[:comments] || []
  
  #   existing_hashes = @album.photos.pluck(:image_hashes).flatten.uniq
  
  #   new_photos = []
  
  #   uploaded_images.each_with_index do |image, i|
  #     image_hash = Photo.generate_image_hash(image)
  #     next if existing_hashes.include?(image_hash)
  
  #     comment = comments[i] || ""
  #     photo = current_user.photos.new(comment: comment, album: @album)
  #     photo.images = [image]
  #     photo.image_hashes = [image_hash]
  #     new_photos << photo
  #   end
  
  #   if new_photos.any?
  #     new_photos.each(&:save)
  #     redirect_to album_path(@album), notice: "画像を登録しました", status: :see_other
  #   else
  #     flash.now[:alert] = "すべての画像が重複していたため、登録されませんでした"
  #     render :new, status: :unprocessable_entity
  #   end
  # end
  
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
      photo.images = [image]
      photo.image_hashes = [image_hash]
  
      new_photos << photo
      new_hashes << image_hash
    end
  
    if new_photos.any?
      new_photos.each(&:save)
      redirect_to album_path(@album), notice: "画像を登録しました", status: :see_other
    else
      flash.now[:alert] = "すべての画像が重複していたため、登録されませんでした"
      render :new, status: :unprocessable_entity
    end
  end
  

  def show
    @album = current_user.albums.find(params[:album_id])
    @photos = @album.photos
  end

  private

  def photo_params
    params.require(:photo).permit(:comment, { images: [] }, :image_cache)
  end
end
