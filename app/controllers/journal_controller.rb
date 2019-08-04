class JournalController < ApplicationController

  get '/journal' do
    if Helpers.is_logged_in? session
      if User.exists? session[:user_id]
        @user = User.find session[:user_id]
        @buckets = @user.buckets
        @moments = @user.moments

        erb :'buckets/journal'
      else
        redirect '/logout'
      end
    else
      redirect '/login'
    end
  end


  post '/journal' do
    #binding.pry
    # {"bucket"=>["7", "1"], "moment_input"=>"200 dangles #dangle invoice", "function"=>"submit"}

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])

        params[:moment][:unit] = Unit.find_or_create_by name: params[:moment][:unit]
        params[:moment][:timestamp] = Time.now
        new_moment = Moment.create params[:moment]

        #binding.pry
        params[:bucket].each do |function, bucket_id|
          #binding.pry
          user_bucket = @user.buckets.find bucket_id

          if user_bucket
            #new_moment.buckets << Bucket.find(bucket_id)
            #BucketMoment.where bucket_id: bucket_id, moment_id: new_moment.id
            multiplier = function == "to" ? 1 : -1
            BucketMoment.create multiplier: multiplier, moment: new_moment, bucket: user_bucket
            binding.pry
          else
            flash[:message] = "You don't have permission to edit this bucket"
          end
        end



      redirect '/journal'

    else
      redirect '/login'
    end


  end
end
