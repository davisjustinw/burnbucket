class JournalController < ApplicationController


  post '/journal' do
    #binding.pry
    # {"bucket"=>["7", "1"], "moment_input"=>"200 dangles #dangle invoice", "function"=>"submit"}

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])

      if params[:bucket]

        params[:moment][:unit] = Unit.find_or_create_by name: params[:moment][:unit]
        #binding.pry
        params[:bucket].each do |bucket_id|
          if @user.buckets.find bucket_id
            Bucket.find(bucket_id).tap do |bucket|
              bucket.moments.new(params[:moment]).tap do |moment|
                moment.value = moment.value * bucket.potential
                moment.save
              end
            end
          else
            flash[:message] = "You don't have permission to edit this bucket"
          end
        end

      else
        flash[:message] = "No bucket selected"
      end

      redirect '/buckets'

    else
      redirect '/login'
    end


  end
end
