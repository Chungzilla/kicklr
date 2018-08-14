require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

require './configuration/application.rb'
require './models/user.rb'
require './models/post.rb'
require './models/tag.rb'
require './models/post_tag.rb'

set :database, {adapter: 'postgresql', database: 'kicklr'}

