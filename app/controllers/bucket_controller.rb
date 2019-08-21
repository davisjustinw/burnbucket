
class BucketController < ApplicationController
  use Rack::Flash

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
      #singularize used to normalize units so views can use plural and singular forms
      params[:bucket][:unit] = Unit.find_or_create_by name: params[:bucket][:unit].singularize
      @bucket = Bucket.new(params[:bucket])

      #use model's validations
      if @bucket.valid?
        @user.buckets << @bucket
        redirect '/journal'
      else
        flash[:messages] = @bucket.errors.messages
        redirect '/buckets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/buckets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])

      #does user have permission to edit the bucket?
      if @user.buckets.exists? params[:id]
        @bucket = @user.buckets.find params[:id]
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

        #does user have permission?
        if @user.buckets.exists?(params[:id])
          @bucket = Bucket.find(params[:id])

          #did the user add a unit?
          if !params[:bucket][:unit].empty?
            params[:bucket][:unit] = Unit.find_or_create_by(name: params[:bucket][:unit].singularize)
            @bucket.update(params[:bucket])
          else
            params[:bucket].delete :unit
            @bucket.update(params[:bucket])
            @bucket.unit = nil
            @bucket.save
          end

          redirect "/journal"
        else
          flash[:message] = "You do not have permission to edit this bucket or it does not exist"
          redirect '/journal'
        end
    else
      redirect '/login'
    end
  end

  delete '/buckets/:id' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])

      #does the user have permission
      if @user.buckets.exists?(params[:id])
        @bucket = Bucket.find(params[:id])
        @bucket.destroy
        redirect '/journal'
      else
        flash[:message] = "You do not have permission to edit this bucket or it does not exist"
        redirect '/journal'
      end
    else
      redirect '/login'
    end

  end

end
