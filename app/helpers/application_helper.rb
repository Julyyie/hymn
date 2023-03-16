module ApplicationHelper
  def user_image_tag(user:, cloudinary_options: {}, html_attributes: {})
    if user.photo.attached?
      cl_image_tag current_user.photo.key, **{**cloudinary_options, **html_attributes}
    else
      image_tag "placeholder.jpg", **html_attributes
    end
  end
end
