class UserController < ApplicationController
  #vestige for now
  get '/:slug' do

    if Helpers.is_logged_in?(session)
      redirect "#{params[:slug]}/buckets"
    else
      erb :'users/login'
    end

  end
end
