class TweetsController < ApplicationController
  class TweetParams
    def self.build(params)
      params.require(:tweet).permit(
        :user_id,
        :tweet_id,
        :message
      )
    end
  end

  def create
    @tweet = Tweet.new(TweetParams.build(params))
    @user = @tweet.user
    get_tweets(nil)
    if @tweet.save
      respond_to do |format|
        format.js
        format.json do
          flash[:success] = "Tweet Successfully Created"
          render json: { redirect_location: users_path }
        end
      end
    end
  end

  def search
    @user = User.find(params[:user_id])
    get_tweets(params[:search])
  
    respond_to do |format|
      format.html
      format.js
      format.json do
        render json: { html: render_to_string(partial: 'search') }
      end
    end
  end

  private

  def get_tweets(search)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end

    if search.blank?
      @tweets = client.user_timeline(@user.twitter_handle)
    else
      query = "from:#{@user.twitter_handle} #{search}"
      @tweets = client.search(query)
    end
  end
end
