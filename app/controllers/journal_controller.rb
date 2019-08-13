class JournalController < ApplicationController

  get '/journal' do
    if Helpers.is_logged_in? session
      if User.exists? session[:user_id]
        @user = User.find session[:user_id]
        @buckets = @user.buckets
        @moments = @user.moments

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

      user_bucket = @user.buckets.find params[:bucket]
      binding.pry
      if user_bucket
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
