
class BucketController < ApplicationController
  get '/buckets' do

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @buckets = @user.buckets
      erb :'buckets/buckets'
    else
      redirect '/login'
    end
  end

  get '/buckets/new' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])

      erb :'buckets/new_bucket'
    else
      redirect '/login'
    end
  end

  post '/buckets' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @user.buckets.create(params[:bucket])
      redirect '/buckets'
    else
      redirect '/login'
    end
  end

end
