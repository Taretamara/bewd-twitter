class TweetsController < ApplicationController
 def create
   token = cookies.permanent.signed[:twitter_session_token]
   session = Session.find_by(token: token)
   if session
     user = session.user
     @tweet = user.tweets.new(tweet_params)
     if @tweet.save
       render 'tweets/create' 
     end
   end
 end
 private
 def tweet_params
    params.require(:tweet).permit(:message)
 end

 def destroy
   token = cookies.permanent.signed[:twitter_session_token]
   session = Session.find_by(token: token)
   if session
     user = session.user
     @tweet = Tweet.find_by(id: params[:id])
     if tweet && tweet.user_id == user.id
       tweet.destroy
       render json: { success: true }
     else
       render json: { success: false }
     end
   end
  end

  def index
    @tweets = Tweet.includes(:user).order(created_at: :desc)
    render 'tweets/index' 
  end

  def index_by_user
    @user = User.find_by(username: params[:username])
    if @user
      @tweets = @user.tweets.order(created_at: :desc)
      render 'tweets/index_by_user'
    else
      render json: { success: false  }
    end
  end
end
