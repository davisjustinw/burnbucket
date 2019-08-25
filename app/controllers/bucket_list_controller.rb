class BucketListController < ApplicationController

  get '/bucket_lists/new' do
    redirect_if_not_logged_in
    @user = User.find(session[:user_id])
    @buckets = @user.buckets
    @bucket_list = BucketList.new(name: "new")

    erb :'bucket_lists/new_bucket_list'
  end #end new bucket_list

  post '/bucket_lists' do
      redirect_if_not_logged_in
      @user = User.find(session[:user_id])

      new_bucket_list = @user.bucket_lists.create params[:bucket_list]
      new_bucket_list.bucket_ids = params[:buckets]

      redirect '/journal'
  end #end post bucket_lists

  get '/bucket_lists/:id/edit' do
      redirect_if_not_logged_in
      @user = User.find(session[:user_id])

      #does user have permission?
      if @user.bucket_lists.exists?(params[:id])

      @buckets = @user.buckets
      @bucket_list = BucketList.find params[:id]

      erb :'bucket_lists/edit_bucket_list'
      else
        flash[:message] = "You do not have permission to edit this bucketlist or it does not exist"
        redirect '/journal'
      end
  end #end get bucket_list

  patch '/bucket_lists/:id' do

    redirect_if_not_logged_in
    @user = User.find(session[:user_id])

    #does user have permission?
    if @user.bucket_lists.exists?(params[:id])
      @bucket_list = BucketList.find(params[:id])
      @buckets = Bucket.find(params[:buckets])

      #validation to only allow two unit types
      if @buckets.uniq {|bucket| bucket.unit_id}.count > 2
        flash[:message] = "only two unit types aloud"
        redirect "/bucket_lists/edit/#{params[:id]}"
      else
        @bucket_list.update(params[:bucket_list])
        @bucket_list.bucket_ids = params[:buckets]
      end
    else
      flash[:message] = "You do not have permission to edit this bucketlist or it does not exist"
    end
    redirect '/journal'

  end #end patch bucket_list

  delete '/bucket_lists/:id' do
    redirect_if_not_logged_in

    @user = User.find(session[:user_id])

    #does user have permission?
    if @user.bucket_lists.exists?(params[:id])
      @bucket_list = BucketList.find(params[:id])
      @bucket_list.destroy
      redirect '/journal'
    else
      flash[:message] = "You do not have permission to edit this bucket_list or it does not exist"
      redirect '/journal'
    end
  end #end delete bucket_list

end #end bucket_list controller
