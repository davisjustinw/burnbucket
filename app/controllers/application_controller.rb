require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get "/" do
    @users = User.all
    if Helpers.is_logged_in?(session)
      redirect '/journal'
    else
      erb :'index'
    end
  end

  get '/signup' do

    session.clear if Helpers.is_logged_in?(session)
    erb :'users/create_user'
  end

  post '/signup' do

    params.delete :submit
    @user = User.new(params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect '/journal'
    else
      flash[:messages] = @user.errors.messages
      redirect '/signup'
    end
  end

  get '/login' do
    @users = User.all
    if Helpers.is_logged_in?(session)
      redirect '/journal'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by username: params[:username]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/journal'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
