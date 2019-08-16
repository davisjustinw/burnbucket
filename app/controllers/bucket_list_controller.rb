class BucketListController < ApplicationController

  get '/bucket_lists/new' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @buckets = @user.buckets

      @bucket_list = BucketList.new(name: "new")
      #binding.pry
      erb :'bucket_lists/new_bucket_list'
    else
      redirect '/login'
    end
  end

  post '/bucket_lists' do
    if Helpers.is_logged_in?(session)

      @user = User.find(session[:user_id])
      new_bucket_list = @user.bucket_lists.create params[:bucket_list]
      new_bucket_list.bucket_ids = params[:buckets]
      #params[:bucket][:unit] = Unit.find_or_create_by name: params[:bucket][:unit]
      #@user.buckets.create(params[:bucket])
      redirect '/journal'
    else
      redirect '/login'
    end
  end



end
