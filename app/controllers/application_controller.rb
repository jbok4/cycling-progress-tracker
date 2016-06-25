require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
     if logged_in? 
      redirect "/rides"
    else
      erb :'/cyclists/create_cyclist', locals: {message: "Please sign up before you sign in"}
    end
  end

  post '/signup' do 
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      @cyclist = Cyclist.new(username: params[:username], email: params[:email], password: params[:password])
      @cyclist.save
      session[:cyclist_id] = @cyclist.id
      redirect "/rides"
    end
  end

  get '/login' do
    if logged_in?  
      redirect "/rides"
    else
      erb :'/cyclists/login'
    end
  end

  post '/login' do
    cyclist = Cyclist.find_by(username: params[:username])
    if cyclist && cyclist.authenticate(params[:password])
      session[:cyclist_id] = cyclist.id
      redirect '/rides'
    else
      redirect '/signup'
    end
  end

   get '/rides' do
    if logged_in? 
      @rides = Ride.all
      @cyclist = Cyclist.find(session[:cyclist_id])
      erb :'rides/rides'
    else
      redirect '/login'
    end   
  end

  get '/rides/new' do
    if logged_in? 
      erb :'rides/create_ride'
    else
      redirect '/login'
    end
  end

  post '/rides' do
    if logged_in? 
      if params[:title].empty?
        redirect '/rides/new'
      else
        @ride = Ride.new(title: params[:title], distance: params[:distance], cyclist_id: session[:cyclist_id])
        @ride.save
        redirect "/rides"
      end
    else
      redirect "/login"
    end
  end

  get '/rides/:id' do 
   if logged_in? 
      @ride = Ride.find_by_id(params[:id])
      erb :'rides/show_ride'
    else 
      redirect '/login'
    end
  end

  get '/rides/:id/edit' do
   if logged_in? 
    @ride = Ride.find_by_id(params[:id])
    if session[:cyclist_id] == @ride.cyclist_id
      erb :'/rides/edit_ride'
    else
      redirect "/rides"
    end
    else
      redirect "/login", locals: {message: "You can only edit your own rides."}
    end
  end

 patch '/rides/:id' do 
    if params[:title] == ""
      redirect to "/rides/#{params[:id]}/edit"
    else
      @ride = Rides.find_by_id(params[:id])
      @ride.title = params[:title]
      @ride.distance = params[:distance]
      @ride.save
      redirect to "/rides"
    end
  end

  delete '/rides/:id/delete' do
    @ride = Ride.find(params[:id])
    if current_cyclist == @ride.cyclist && logged_in?
      @ride.delete
      redirect '/rides'
    else
      redirect '/login'
    end
  end

  get "/cyclists/:slug" do
    @cyclist = Cyclist.find_by_slug(params[:slug])
    erb :'/cyclists/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  

  helpers do
    def logged_in?
      !!session[:cyclist_id]
    end

    def current_cyclist
      Cyclist.find(session[:cyclist_id])
    end

  end

end