class LikesController < ApplicationController
	before_action :find_tweet
	before_action :find_like, only: [:destroy]

	def index
	end

	def create
		if already_liked?
			flash[:alert] = "You can only like a DashNote once."
		else
		    @tweet.likes.create(user_id: current_user.id)
		end
		redirect_to root_path
	end

	def destroy
		if !(already_liked?)
			flash[:alert] = "Cannot unlike"
		else
			@like.destroy
		end
		redirect_to root_path
	end

private
	
	def find_tweet
		@tweet = Tweet.find(params[:tweet_id])
	end

	def already_liked?
		Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
	end

	def find_like
		@like = @tweet.likes.find(params[:id])
	end
end
