
class BucketController < ApplicationController

  get '/buckets/new' do
    redirect_if_not_logged_in

    @user = User.find(session[:user_id])
    @bucket = Bucket.new(name: "new")
    erb :'buckets/new_bucket'
  end #end new bucket

  post '/buckets' do
    redirect_if_not_logged_in

    @user = User.find(session[:user_id])
    #singularize used to normalize units so views can use plural and singular forms
    params[:bucket][:unit] = Unit.find_or_create_by name: params[:bucket][:unit].singularize
    @bucket = @user.buckets.build(params[:bucket])

    #use model's validations
    if @bucket.save
      redirect '/journal'
    else
      flash[:messages] = @bucket.errors.messages
      redirect '/buckets/new'
    end
  end #end post bucket

  get '/buckets/:id/edit' do
    redirect_if_not_logged_in

    @user = User.find(session[:user_id])

    #does user have permission to edit the bucket?
    @bucket = @user.buckets.find_by_id params[:id]

    if @bucket

      erb :'buckets/edit_bucket'
    else
      flash[:message] = "You do not have permission to edit this bucket or it does not exist"
      redirect '/journal'
    end

  end #end of get bucket

  patch '/buckets/:id' do
    redirect_if_not_logged_in
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
  end #End of patch

  delete '/buckets/:id' do
    redirect_if_not_logged_in
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
  end #End of delete

end #End of class
