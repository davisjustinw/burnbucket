
class BucketController < ApplicationController

  get '/buckets' do
    if Helpers.is_logged_in? session
      if User.exists? session[:user_id]
        @user = User.find session[:user_id]
        @buckets = @user.buckets
        @moments = @user.moments
        
        erb :'buckets/buckets'
      else
        redirect '/logout'
      end
    else
      redirect '/login'
    end
  end

  get'/buckets/detail' do
    #buckets/detail
    binding.pry

    redirect '/buckets'
  end

  get '/buckets/new' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @potential = params[:potential]
      @bucket = Bucket.new(name: "new")
      erb :'buckets/new_bucket'
    else
      redirect '/login'
    end
  end

  post '/buckets' do
    if Helpers.is_logged_in?(session)

      @user = User.find(session[:user_id])
      @user.buckets.create(params[:bucket])
      redirect '/buckets'
    else
      redirect '/login'
    end
  end

  get '/buckets/:slug/edit' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @bucket = @user.buckets.find_by_slug params[:slug]

      if @bucket
        @moments = @bucket.moments
        erb :'buckets/edit_bucket'
      else
        flash[:message] = "You do not have permission to edit this bucket or it does not exist"
        redirect '/buckets'
      end
    else
      redirect '/login'
    end
  end

  get '/buckets/:slug' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @bucket = @user.buckets.find_by_slug params[:slug]

      if @bucket
        @moments = @bucket.moments
        erb :'buckets/show_bucket'
      else
        flash[:message] = "You don't have permission to view this bucket #{params[:slug]}, or it does't exist"
        redirect '/buckets'
      end
    else
      redirect '/login'
    end
  end



  patch '/buckets/:id' do
    if Helpers.is_logged_in?(session)
        @user = User.find(session[:user_id])
        if @user.buckets.exists?(params[:id])
          @bucket = Bucket.find(params[:id])
          @bucket.update(params[:bucket])

          #update moments
        if params[:moments]
          binding.pry
          params[:moments].each do |moment|
            moment[:unit] = Unit.find_or_create_by(name: moment[:unit])
            @bucket.moments.find(moment[:id]).update(moment)
          end
        end

          #add new moment
          if !params[:new_moment].empty?
            params[:new_moment][:unit] = Unit.find_or_create_by(name: params[:new_unit][:name])
            @bucket.moments.create(params[:new_moment])
          end

          redirect "buckets/#{@bucket.id}"
        else
          flash[:message] = "You do not have permission to edit this bucket or it does not exist"
          redirect '/buckets'
        end
    else
      redirect '/login'
    end
  end

  delete '/buckets/:id' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      if @user.buckets.exists?(params[:id])
        @bucket = Bucket.find(params[:id])
        @bucket.destroy
        redirect '/buckets'
      else
        redirect '/buckets'
      end
    else
      redirect '/login'
    end

  end

end
