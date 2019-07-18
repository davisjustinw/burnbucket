class JournalController < ApplicationController


  post '/journal' do
    #binding.pry
    # {"bucket"=>["7", "1"], "moment_input"=>"200 dangles #dangle invoice", "function"=>"submit"}

    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])

      if params[:bucket]
        value_unit, note = params[:moment_input].split('#')
        value, unit = value_unit.strip.split(' ', 2)
        value = value.to_i

        unit = Unit.find_or_create_by name: unit if unit

        params[:bucket].each do |bucket_id|
          if @user.buckets.find bucket_id
            Bucket.find(bucket_id).tap do |bucket|
              bucket.potential ? new_value = value * -1 : new_value = value
              bucket.moments.create name: note, unit: unit, value: new_value
              binding.pry
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
