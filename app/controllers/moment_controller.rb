class MomentController < ApplicationController

  get '/moments/:id/edit' do

    redirect_if_not_logged_in
    @user = User.find session[:user_id]
    @moment = @user.moments.find_by_id params[:id]

    if @moment
      @buckets = @user.buckets
      erb :'moments/edit_moment'
    else
      flash[:message] = "You don't have persmission to edit this moment or it doesn't exist"
      redirect '/journal'
    end

  end # get moments

  patch '/moments/:id' do

    redirect_if_not_logged_in
    @user = User.find session[:user_id]
    @moment = @user.moments.find_by_id params[:id]
    @bucket = @user.buckets.find_by_id params[:moment][:bucket]

    if @moment && @bucket
      params[:moment][:bucket] = @bucket
      params[:moment][:timestamp] = Time.now
      @moment.update params[:moment]
    else
      flash[:message] = "You do not have permission to edit this moment or bucket, or they don't exist"
    end
    redirect '/journal'

  end #patch moment

  delete '/moments/:id' do
    redirect_if_not_logged_in
    @user = User.find session[:user_id]
    @moment = @user.moments.find_by_id params[:id]

    if @moment
      @moment.destroy
      redirect '/journal'
    else
      flash[:message] = "You do not have permission to edit this moment or it does not exist"
      redirect '/journal'
    end

  end #delete moment

end #journal controller
