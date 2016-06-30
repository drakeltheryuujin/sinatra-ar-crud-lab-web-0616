require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #home
  get '/' do 
    redirect "posts"
  end

  #new
  get '/posts/new' do
    erb :new
  end

  #create new post
  post "/posts" do
    @post = Post.create(params)
    redirect "posts"
  end

  #show all posts
  get '/posts' do 
    @posts = Post.all
    erb :index
  end

  #show individual post
  get '/posts/:id' do
    @post = Post.find(params[:id])

    erb :show
  end

  #edit individual post
  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  #updates individual post
  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(name: params["name"], content: params["content"])
    
    redirect "/posts/#{@post.id}"
  end

  #deletes individual post
  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.destroy

    erb :delete
  end
  
end
