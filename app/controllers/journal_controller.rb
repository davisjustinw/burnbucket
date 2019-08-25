class JournalController < ApplicationController

  get '/journal' do
    redirect_if_not_logged_in
    if User.exists? session[:user_id]
      @user = User.find session[:user_id]

      # grab user's bucket lists.  Had to use select to make it sortable
      @bucket_lists = @user.bucket_lists.select{|bl| true}
      @bucket_lists.sort_by!{|bucket_list| bucket_list[:name].downcase}

      # grab user's buckets.  Had to use select to make it sortable
      @buckets = @user.buckets
      @free_buckets = @buckets.select {|bucket| !bucket.bucket_list}
      @free_buckets.sort_by!{|bucket| bucket[:name].downcase}

      @moments = @user.moments

      erb :'buckets/journal'
    else
      redirect '/logout'
    end

  end #end get journal


  post '/journal' do

    redirect_if_not_logged_in
    @user = User.find(session[:user_id])

    params[:moment][:timestamp] = Time.now
    user_bucket = @user.buckets.find params[:moment][:bucket]

    if user_bucket
      #params[:moment].delete :bucket
      #user_bucket.moments.create params[:moment]
      params[:moment][:bucket] = user_bucket
      newMoment = Moment.new params[:moment]
      if newMoment.valid?
        newMoment.save
        redirect '/journal'
      else
        flash[:messages] = newMoment.errors.messages
        redirect '/journal'
      end
    else
      flash[:message] = "You don't have permission to edit this bucket"
    end

    redirect '/journal'
  end #post journal
end
