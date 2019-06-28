class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect to :'users/profile'
        else
            erb :'users/signup'
        end
    end

    post '/signup' do ### Checkpoint. Need to complete signup process
        if params[:first_and_last] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        end
        @user = User.create(email: params[:email], first_and_last: params[:first_and_last], password: params[:password])
        session[:user_id] = @user.id 
        redirect '/login'
    end

end