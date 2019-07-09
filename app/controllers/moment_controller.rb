class MomentController < ApplicationController

  get '/moments' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @moments = @user.moments
      erb :'moments/moments'
    else
      redirect '/login'
    end
  end

  get '/moments/new' do

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @moment = Moment.new(name: "new")
      erb :'moments/new_moment'
    else
      redirect '/login'
    end
  end

  post '/moments' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @user.moments.create(params[:moment])
      redirect '/moments'
    else
      redirect '/login'
    end
  end
end
