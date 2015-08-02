module UsersHelper

  def user_head_image_url(user, options = {size: 80})
    img_url = user.user_img
    size = options[:size]
    if img_url.blank?
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      img_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    else
      img_url += "?imageView/1/w/#{size}/h/#{size}"
    end
    image_tag(img_url, alt: user.name, class: 'gravatar')
  end

end