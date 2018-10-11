require './app'
run Sinatra::Application

set :public_folder, File.join(APP_ROOT, "public")