module UsersHelper

  DEFAULT_USER_AVATAR = 'http://7xktkg.com1.z0.glb.clouddn.com/default_avatar.jpg'

  def user_avatar_url(user, options = {size: 80})

    img_url = user.avatar.url if (user && user.avatar?)
    size = options[:size]

    if img_url.blank?
      img_url = "#{DEFAULT_USER_AVATAR}?imageView/1/w/#{size}/h/#{size}"
    else
      img_url += "?imageView/1/w/#{size}/h/#{size}"
    end

    img_url

  end

  def user_avatar(user, options = {size: 80})

    img_url = user_avatar_url(user, options)

    options[:alt] = user.name
    options[:class] = 'avatar'
    options[:size] = options[:size].to_s

    image_tag(img_url, options)
  end

  def my_avatar(options = {size: 80})

    user = User.find_by_email('yangsongfwd@163.com')

    img_url = user_avatar_url(user, options)

    options[:alt] = user.name
    options[:class] ||= 'avatar'
    options[:size] = options[:size].to_s

    image_tag(img_url, options)
  end

end