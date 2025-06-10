module AlbumsHelper
  def cover_image_path(template)
    case template
    when "pink" then "covers/pink.jpg"
    when "blue" then "covers/blue.jpg"
    when "green" then "covers/green.jpg"
    when "black" then "covers/black.jpg"
    when "white" then "covers/white.jpg"
    else "covers/star.jpg"
    end
  end

  def background_class(template)
    case template
    when "pink" then "bg-pink-100"
    when "blue" then "bg-blue-100"
    when "green" then "bg-green-100"
    when "black" then "bg-black/10"
    when "white" then "bg-gray-100"
    else "bg-sky-100"
    end
  end
end
