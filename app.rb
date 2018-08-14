require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

require './models/user.rb'
require './models/post.rb'
require './models/tag.rb'
require './models/post_tag.rb'

set :database, {adapter: 'postgresql', database: 'kicklr'}

enable :sessions

get '/' do
    if session[:user_id]
        erb :layout
    else
        erb :signed_in_homepage
    end
end

get "/sign-up" do
    erb :sign_up
end

get "/sign-in" do
    erb :sign_up
end

