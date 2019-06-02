
class BucketController < ApplicationController
  get '/buckets' do

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @buckets = @user.buckets
      erb :'buckets/buckets'
    else
      redirect '/login'
    end
  end

  get '/buckets/new' do

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
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

  get '/buckets/:slug' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @bucket = @user.buckets.find_by_slug params[:slug]

      if @bucket
        @entries = @bucket.entries
        erb :'buckets/show_bucket'
      else
        flash[:message] = "You don't have permission to view the bucket #{params[:slug]}, or it does't exist"
        redirect '/buckets'
      end
    else
      redirect '/login'
    end
  end

  get '/buckets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      if @user.buckets.exists?(params[:id])
        @bucket = Bucket.find(params[:id])

        @entries = @bucket.entries
        erb :'buckets/edit_bucket'
      else
        flash[:message] = "You do not have permission to edit this bucket or it does not exist"
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

          #update entries
          params[:entries].each do |entry|
            @bucket.entries.find(entry[:id]).update(entry)
          end

          #add new entry
          if !params[:new_entry].empty?
            @bucket.entries.create(params[:new_entry])
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

end
