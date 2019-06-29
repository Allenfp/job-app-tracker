class JobsController < ApplicationController

    get '/job/new' do
        if logged_in?
            erb :'jobs/new'
        else
            redirect to '/login'
        end
    end

    post '/job' do
        if logged_in?
            if params[:title] == "" || params[:job_description] == "" 
                redirect to '/job/new'
            else
                binding.pry
                @job = current_user.jobs.create(title: params[:title])
                redirect '/profile'
            end  
        else
            redirect to '/login'
        end
    end

end