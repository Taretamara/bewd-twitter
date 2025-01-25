class TweetsController < ApplicationController
 def create
   token = cookies.signed[:twitter_session_token]
   session = Session.find_by(token: token)
   if session
     user = session.user
     @tweet = user.tweets.new(tweet_params)
     if @tweet.save
       render 'tweets/create' 
     end
   end
 end

 def destroy
   token = cookies.signed[:twitter_session_token]
   session = Session.find_by(token: token)
   if session
     user = session.user
     @tweet = Tweet.find_by(id: params[:id])
     if tweet && (tweet.user == user) && tweet.destroy
       render json: { success: true }
     else
       render json: { success: false }
     end
   end
  end

  def index
    @tweets = Tweet.all.includes(:user).order(created_at: :desc)
    render 'tweets/index' 
  end

  def index_by_user
    user = User.find_by(username: params[:username])
    if user
      @tweets = user.tweets
      render 'tweets/index'
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:message)
  end
end
