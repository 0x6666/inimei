module Blog::CommentsHelper
  def comment_visitor_desc(comment)

    return 'Visitor' if comment.nil?

    return comment.user.name unless comment.user.nil?

    unless comment.visitor.nil?
      return 'Visitor (' + comment.visitor.ip + ')' if comment.post.user == current_user
    end

    'Visitor'
  end

  def can_delete(comment)
    return false  if comment.nil? || comment.post.nil?
    user = comment.user

    unless user.nil?
      return true if user == current_user
    end

    comment.post.user == current_user
  end
end
