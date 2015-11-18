class Api::V1::PostsController < Api::V1::BaseController
    
   before_filter :authenticate_user, except: [:index, :show]
   before_filter :authorize_user, except: [:index, :show]
   
   def index
     posts = Post.all
     render json: posts.to_json, status: 200
   end
   
   def show
     post = Post.find(params[:id])
     comments = Comment.where(post_id: post.id)
     render json: {post: post, comments: comments}.to_json, status: 200
   end
   
end