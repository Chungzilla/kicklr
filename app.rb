require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'


require './models/user.rb'
require './models/post.rb'
require './models/tag.rb'
require './models/post_tag.rb'

enable :sessions

#Render Sign-In form
get "/sign-in" do
    erb :sign_in
end

#Responds to Sign-In form
post '/sign-in' do
    @user = User.find_by(username: params[:username])

    #Check if user exists and if password matches wat is in databse
    if @user && @user.password == params[:password]

        #Sign the user in
        session[:user_id] = @user.id

        #Confirm to User that they are signed in
        flash[:info] = "You are signed in!"

        #Send user to hompage
        redirect '/'
    else
        flash[:warning] = "Your Username and/or Password is incorrect"

        #Send user to sign-in again 
        redirect '/sign-in'
    end
end

get "/sign-up" do
    erb :sign_up
end

post "/sign-up" do
   
    @user = User.create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        username: params[:username],
        email: params[:email],
        password: params[:password],
        birthday: params[:birthday]
    )

        #Sign User In
        session[:user_id] = @user.id

        #Notify User of sign-up was successful
        flash[:info] = "Congrats, you have signed up! You are being taken to your homepage now!"

        #Send User to homepage
        redirect '/'
end



get '/' do
    if session[:user_id]
        @user =  User.find(session[:user_id])
        @user_posts = @user.posts
        erb :signed_in_homepage
    else
        erb :index
    end    
end

post '/sign-out' do
    #Grab current user id
    @user = User.find_by(username: params[:username])

    #Ends current cookie session
    session[:user_id] = nil

    #Send user to homepage 
    redirect '/'
end

get '/post/new' do
    if session[:user_id]
        erb :new_post

    else
        redirect '/sign-in'
    end
end

post '/post/new' do
    #User can create a new post 
    #Only when signed in
    if session[:user_id]
        @user = User.find(session[:user_id])
        @new_post = Post.create(
             
        )
        erb :new_post
    else
        redirect '/'
    end
end

get '/:username' do
   #View profile by Username
   erb :profile_view
end

get '/:username/edit-post/:id' do
    #Allows user to edit a specific post

    erb :edit_post
end