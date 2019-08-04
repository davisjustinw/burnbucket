class JournalController < ApplicationController


  post '/journal' do
    #binding.pry
    # {"bucket"=>["7", "1"], "moment_input"=>"200 dangles #dangle invoice", "function"=>"submit"}

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])

      if params[:bucket]

        params[:moment][:unit] = Unit.find_or_create_by name: params[:moment][:unit]
        new_moment = Moment.create params[:moment]
        binding.pry
        params[:bucket].each do |bucket_id|
          if @user.buckets.find bucket_id
            new_moment.buckets << Bucket.find(bucket_id)
          else
            flash[:message] = "You don't have permission to edit this bucket"
          end
        end
        binding.pry

      else
        flash[:message] = "No bucket selected"
      end

      redirect '/buckets'

    else
      redirect '/login'
    end


  end
end
