class BucketController < ApplicationController

  get '/:slug/buckets' do
    if Helpers.is_logged_in?(session)
        @user = User.find_by_slug( params[:slug] )

        if @user.id == session[:user_id]
          @buckets = @user.buckets
          erb :'buckets/buckets'
        else
          flash[:message] = "You don't have permission to view #{params[:slug]}'s buckets', or they does't exist"
          redirect '/buckets'
        end
    else
      redirect '/login'
    end
  end

end
