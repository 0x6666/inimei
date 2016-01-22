module UilHelper
  def user_blog_index_url(user)
    blog_root_url subdomain: user.blog_setting.domain
  end
end