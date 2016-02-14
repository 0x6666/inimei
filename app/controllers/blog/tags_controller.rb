class Blog::TagsController < Blog::BlogBaseController
  def show
    @setting = blog_setting
    @tag = retrieve_tag
    if @tag
      @page = nil
      @posts = @tag.posts_with_tag
    else
      redirect_to :root ,notice: "No post found with label \"#{params[:tag]}\""
    end
  end

  private
  def retrieve_tag
    Blog::Tag.where('lower(name) = ?', params[:tag].mb_chars.to_s.downcase).first
  end
end
