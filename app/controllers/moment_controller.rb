class MomentController < ApplicationController

  get '/moments/:id/edit' do

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])

      if @user.moments.exists?(params[:id])
        @moment = Moment.find(params[:id])
        @buckets = @user.buckets
        erb :'moments/edit_moment'
      else
        flash[:message] = "You don't have persmission to edit this moment or it doesn't exist"
        redirect '/journal'
      end
    else
      redirect '/login'
    end
  end

  patch '/moments/:id' do

    if Helpers.is_logged_in?(session)

      @user = User.find(session[:user_id])
      if @user.moments.exists?(params[:id]) && @user.buckets.exists?(params[:moment][:bucket])
        @moment = Moment.find(params[:id])

        params[:moment][:bucket] = Bucket.find(params[:moment][:bucket])
        @moment.update(params[:moment])

      else
        flash[:message] = "You do not have permission to edit this moment or bucket, or they don't exist"
      end
      redirect '/journal'
    else
      redirect '/login'
    end


  end


end
