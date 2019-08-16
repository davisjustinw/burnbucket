class BucketListController < ApplicationController

  get '/bucket_lists/new' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @buckets = @user.buckets

      @bucket_list = BucketList.new(name: "new")

      erb :'bucket_lists/new_bucket_list'
    else
      redirect '/login'
    end
  end

  post '/bucket_lists' do
    if Helpers.is_logged_in?(session)

      @user = User.find(session[:user_id])
      new_bucket_list = @user.bucket_lists.create params[:bucket_list]
      buckets = params[:buckets]
      new_bucket_list.bucket_ids = params[:buckets]

      redirect '/journal'
    else
      redirect '/login'
    end
  end

  get '/bucket_lists/edit/:id' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @buckets = @user.buckets

      @bucket_list = BucketList.find params[:id]

      erb :'bucket_lists/edit_bucket_list'
    else
      redirect '/login'
    end
  end

  patch '/bucket_lists/:id' do
    if Helpers.is_logged_in?(session)

      @user = User.find(session[:user_id])
      if @user.bucket_lists.exists?(params[:id])
        @bucket_list = BucketList.find(params[:id])
        @bucket_list.update(params[:bucket_list])
        @bucket_list.bucket_ids = params[:buckets]
      else
        flash[:message] = "You do not have permission to edit this bucket or it does not exist"
      end
      redirect '/journal'
    else
      redirect '/login'
    end
  end





end
