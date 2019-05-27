
class BucketController < ApplicationController
  get '/buckets' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      #@buckets = Buckets.all
      erb :'buckets/buckets'
    else
      redirect '/login'
    end
  end
end
