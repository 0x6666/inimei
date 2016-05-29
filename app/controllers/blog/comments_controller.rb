class Blog::CommentsController < Blog::BlogBaseController
  include Blog::CommentsHelper

  skip_before_filter :verify_authenticity_token

  def create

    @post = Blog::Post.find(params[:post_id])
    @comment = nil

    if !@post.nil?
      @comment = Blog::Comment.new comment_params
      @comment.post= @post

      if u = current_user
        @comment.user = u
      else
        @comment.visitor = Visitor.get_or_create_visitor request.ip
      end

      @comment = nil unless @comment.save
    end

    respond_to do |format|
      format.html { redirect_to blog_root_path }
      format.js
    end
  end

  def destroy
    @post = Blog::Post.find(params[:post_id])
    @id = params[:id]
    @comment = Blog::Comment.find(@id)
    if can_delete(@comment)
      @comment.destroy
    end

    respond_to do |format|
      format.html { redirect_to blog_root_path }
      format.js
    end
  end

  private
  def comment_params
    params.require(:blog_comment).permit(:content)
  end
end
