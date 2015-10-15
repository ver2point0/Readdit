class SponsoredPostsController < ApplicationController
  
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def sponsored_post_params
    params[:sponsored_post].permit(:title, :body, :price)  
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new(sponsored_post_params)
    @sponsored_post.topic = @topic
    
    if @sponsored_post.save
      flash[:notice] = "Sponsored post was saved successfully."
      redirect_to [@topic, @sponsored_post]
    else
      flash[:error] = "There was an error saving the sponsored post. Please try again."
      render :new
    end
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.update(sponsored_post_params)
    
    if @sponsored_post.save
      flash[:notice] = "Sponsored post was updated."
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash[:error] = "There was an error saving the sponsored post. Please try again."
      render :edit
    end
  end
  
  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end
  
  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])
    
    if @sponsored_post.destroy
      flash[:notice] = "\"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash[:error] = "There was an error deleting the sponsored_post."
      render :show
    end
  end
end
