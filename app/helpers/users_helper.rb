module UsersHelper
  
  def user_comments?(user)
     user.comments.any? ? "Comments" : "#{user.name} has not submitted any comments yet."
  end
  
  def user_posts?(user)
    user.posts.any? ? "Posts" : "#{user.name} has not submitted any posts yet."
  end
  
  def user_favorites?(user) 
    user.favorites.any? ? "Favorites" : "#{user.name} has no favorite posts yet."  
  end
end
