class UsersController < ApplicationController
  class UserParams
    def self.build(params)
      params.require(:user).permit(
        :email,
        :name,
        :twitter_handle
      )
    end
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def show
    @user = User.find(params[:id])
    get_tweets(nil)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @user = User.new(UserParams.build(params))
    respond_to do |format|
      format.js
      if @user.save
        format.json do
          flash[:success] = "User Successfully Created"
          render json: { redirect_location: users_path }
        end
        format.js { flash[:notice] = "User Successfully Created" }
      else
        flash[:error] = "Something was wrong with your user"
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(UserParams.build(params))
      respond_to do |format|
        format.json do
          flash[:success] = "User Successfully Updated"
          render json: { redirect_location: users_path }
        end
      end
    end
  end

  def tweets
    get_tweets(params[:search_text])
    
    respond_to do |format|
      format.json do
        render json: { html: render_to_string(partial: 'tweets') }
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

    if search.nil?
      @tweets = client.user_timeline(@user.twitter_handle)
    else
      @tweets = client.search("from:#{@user.twitter_handle} #{search}")
    end
  end
end
