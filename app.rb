require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

set :database, {adapter: 'postgresql', database: 'kicklr'}

