class JournalController < ApplicationController


  post '/journal_entries' do
    binding.pry

    redirect '/buckets'
  end
end
