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
        flash[:warning] = "Your Username and/or Password is incorrect."

        #Send user to sign-in again 
        redirect '/sign-in'
    end
end

#Renders Sign Up page
get "/sign-up" do
    erb :sign_up
end

#Creates new account for user
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
    flash[:info] = "Congrats, you have signed up!"

    #Send User to homepage
    redirect '/'
end


#Root - view user page when signed in/ landing page when siged out
get '/' do
    if session[:user_id]
        @user =  User.find(session[:user_id])
        @user_posts = @user.posts
        erb :signed_in_homepage
    else
        erb :index, :layout => false;
    end    
end

#Signs out current user
post '/sign-out' do
    #Grab current user id
    @user = User.find_by(username: params[:username])

    #Ends current cookie session
    session[:user_id] = nil

    #Send user to homepage 
    redirect '/'
end

#Renders Create Post page
get '/post/new' do
        erb :new_post
end

get '/posts' do
    @user = User.find(session[:user_id])
    @user_posts = Post.order('created_at DESC').all

    erb :signed_in_homepage
end

post '/posts' do
    if session[:user_id]
        @user = User.find(session[:user_id])
        Post.create(
            title: params[:title],
            content: params[:content], 
            user_id: session[:user_id]
        )
        redirect '/'
    else
        flash[:warning] = "You must be logged in to create a post."
        redirect '/'
    end
end

get '/posts/:id/edit' do
    @post_to_edit = Post.find(params[:id])
    erb :edit_post
end

put '/posts/:id/edit' do
    @post_to_edit = Post.find(params[:id])
    @post_to_edit.update(
        title: params[:title],
        content: params[:content],
        )
    redirect '/posts'

end

delete '/posts/:id/delete' do
    @post_to_delete = Post.find(params[:id])
    @post_to_delete.destroy
 
    redirect '/'
end

get '/users/:username/account' do
    @user = User.find_by(username: params[:username])

    erb :user_account
end

#Delete User account
delete '/users/:id' do
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    flash[:info] = "Your account has been successfully deleted."
    redirect '/'
end