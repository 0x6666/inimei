module UsersHelper

  def user_avatar(user, options = {size: 80})
    img_url = user.avatar.url if user.avatar?
    size = options[:size]
    if img_url.blank?
      img_url = "http://7xktkg.com1.z0.glb.clouddn.com/default_avatar.jpg?imageView/1/w/#{size}/h/#{size}"
    else
      img_url += "?imageView/1/w/#{size}/h/#{size}"
    end
    image_tag(img_url, alt: user.name, class: 'avatar')
  end

end