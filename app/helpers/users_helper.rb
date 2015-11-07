module UsersHelper
  
  def user_comments?(user)
     user.comments.any? ? "Comments" : "#{user.name} has not submitted any comments yet."
  end
  
  def user_posts?(user)
    user.posts.any? ? "Posts" : "#{user.name} has not submitted any posts yet."
  end
end
