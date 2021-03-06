class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect to '/users/profile'
        else
            @error_message = ""
            erb :'users/signup'

        end
    end

    post '/signup' do 
        if params[:first_last_name] == "" || params[:username] == "" || params[:pwd] == ""
            redirect '/signup'
        elsif !User.find_by(username: params[:username]).nil?
            @error_message = '<h4>ERROR: Username Unavailable. If you have an account already, <a href="/">login here.</a></h4>'
            erb :'users/signup'
        else
            @user = User.create(:username => params[:username], :first_last_name => params[:first_last_name], :password => params[:pwd])
            session[:user_id] = @user.id 
            redirect '/profile'
        end
    end

    post '/login' do
        user = User.find_by(:username => params[:email])
        if user && user.authenticate(params[:pwd])
            session[:user_id] = user.id
            redirect "/profile"
        else
            redirect '/'
        end
    end

    get '/profile' do 

        if logged_in?
            @user = User.find_by_id(session[:user_id])
            @jobs = @user.jobs.all
            erb :'users/profile'
        else
            redirect to '/'
        end
    end


    get '/logout' do
        session.clear
        redirect '/'
    end

end