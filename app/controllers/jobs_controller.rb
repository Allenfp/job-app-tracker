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
                @job = current_user.jobs.create(title: params[:title],
                    job_description: params[:job_description],
                    min_years_exp: params[:min_years_exp],
                    website_applied: params[:website_applied],
                    resume_used: params[:resume_used],
                    contacted: params[:contacted],
                    onsite: params[:onsite],
                    offer: params[:offer],
                    offer_amount: params[:offer_amount],
                    user_id: params[:user_id])
                redirect '/profile'
            end  
        else
            redirect to '/login'
        end
    end

    get '/job/:id' do
        if logged_in?
          @user = current_user
          @job = @user.jobs.find_by_id(params[:id])
          erb :'jobs/view'
        else
          redirect :'/'
        end
    end

    get '/job/:id/edit' do
        if logged_in?
            @user = current_user
            @job = @user.jobs.find_by_id(params[:id])
            erb :'jobs/edit'
        else
            redirect :'/'
        end
    end


    patch '/job/:id' do
        binding.pry
    end

end