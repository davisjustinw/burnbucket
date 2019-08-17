class JournalController < ApplicationController

  get '/journal' do
    if Helpers.is_logged_in? session
      if User.exists? session[:user_id]
        @user = User.find session[:user_id]
        @bucket_lists = @user.bucket_lists

        @buckets = @user.buckets
        @free_buckets = @buckets.select {|bucket| !bucket.bucket_list}
        @free_buckets.sort_by!(&:name)

        @moments = @user.moments
        #binding.pry
        erb :'buckets/journal'
      else
        redirect '/logout'
      end
    else
      redirect '/login'
    end
  end


  post '/journal' do

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])

      params[:moment][:timestamp] = Time.now
      user_bucket = @user.buckets.find params[:moment][:bucket]

      if user_bucket
        params[:moment].delete :bucket
        user_bucket.moments.create params[:moment]
      else
        flash[:message] = "You don't have permission to edit this bucket"
      end

      redirect '/journal'

    else
      redirect '/login'
    end


  end
end
