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
    return false  if comment.nil? || comment.post.nil? || current_user.nil?

    return true if comment.post.user_id == current_user.id
    return false unless comment.user_id.nil?
    comment.user_id == current_user.id

  end
end
