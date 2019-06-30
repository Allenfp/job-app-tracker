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
        # binding.pry
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

        if logged_in?

            if params[:title] == "" || params[:job_description] == ""
                redirect to "/job/#{params[id]}/edit"

            else 
                
                @user = current_user
                @job = @user.jobs.find_by_id(params[:id])
                @job.update(title: params[:title],
                            job_description: params[:job_description],
                            min_years_exp: params[:min_years_exp],
                            website_applied: params[:website_applied],
                            resume_used: params[:resume_used],
                            contacted: params[:contacted],
                            onsite: params[:onsite],
                            offer: params[:offer],
                            offer_amount: params[:offer_amount],
                            notes: params[:notes])
                
                redirect to "/job/#{params[:id]}"
            end
        else
            redirect to '/'
        end

    end

    get '/job/:id/delete' do 
        @job = current_user.jobs.find_by_id(params[:id])
        erb :'jobs/delete'
    end

    delete '/job/:id/delete' do
        if logged_in?
          @job = current_user.jobs.find_by_id(params[:id])
          binding.pry
          if @job
            @job.delete
            redirect to "/profile"
          else
            redirect to "/job/#{params[:id]}"
          end

        else
          redirect to '/'
        end
      end
end