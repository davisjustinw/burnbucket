class MomentController < ApplicationController

  get '/moments/:id/edit' do

    redirect_if_not_logged_in
    @user = User.find(session[:user_id])

    if @user.moments.exists?(params[:id])
      @moment = Moment.find(params[:id])
      @buckets = @user.buckets
      erb :'moments/edit_moment'
    else
      flash[:message] = "You don't have persmission to edit this moment or it doesn't exist"
      redirect '/journal'
    end

  end # get moments

  patch '/moments/:id' do

    redirect_if_not_logged_in

    @user = User.find(session[:user_id])
    if @user.moments.exists?(params[:id]) && @user.buckets.exists?(params[:moment][:bucket])
      @moment = Moment.find(params[:id])

      params[:moment][:bucket] = Bucket.find(params[:moment][:bucket])
      params[:moment][:timestamp] = Time.now


        @moment.update(params[:moment])


    else
      flash[:message] = "You do not have permission to edit this moment or bucket, or they don't exist"
    end
    redirect '/journal'

  end #patch moment

  delete '/moments/:id' do
    redirect_if_not_logged_in

    @user = User.find(session[:user_id])
    if @user.moments.exists?(params[:id])
      @moment = Moment.find(params[:id])
      @moment.destroy
      redirect '/journal'
    else
      flash[:message] = "You do not have permission to edit this moment or it does not exist"
      redirect '/journal'
    end

  end #delete moment

end #journal controller
