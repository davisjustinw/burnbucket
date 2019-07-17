class JournalController < ApplicationController


  post '/journal' do
    binding.pry
    # {"bucket"=>["7", "1"], "moment_input"=>"200 dangles #dangle invoice", "function"=>"submit"}
    value_unit, note = params[:moment_input].split('#')
    value, unit = value_unit.strip.split(' ', 2)
    value = value.to_i
    unit = Unit.find_by name: unit

    params[:bucket].each do |bucket_id|
      Bucket.find(bucket_id).tap do |bucket|
        value = value * -1 if bucket.potential
        bucket.moments.create name: note, unit: unit, value: value
      end
    end

    redirect '/buckets'
  end
end
