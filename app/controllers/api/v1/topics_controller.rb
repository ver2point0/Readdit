class Api::V1::TopicsController < Api::V1::BaseController
  
  
  before_filter :authenticate_user, except: [:index, :show]
  before_filter :authorize_user, except: [:index, :show]
  
  def index
    topics = Topic.all
    render json: topics.to_json, status: 200
  end
  
  def show
    topic = Topic.find(params[:id])
    render json: topic.to_json, status: 200
  end
  
end