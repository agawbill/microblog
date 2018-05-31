require 'sinatra'
require 'sinatra/activerecord'
require './models'



set :database, 'sqlite3:users.sqlite3'
# one database with multiple tables
set :sessions, true


def current_user
if(session[:user_id])
  @current_user = User.find(session[:user_id])
end
end

get "/" do
  @users=User.all
  erb :'users/index'
end

get "/signup" do
erb :'users/signup'
end


post "/signup" do
  user= User.create(username: params[:username], password: params[:password])
  redirect "/"
end


get "/login" do
  erb :'users/login'
end


post "/login" do
  user=User.where(username: params[:username]).first
  if user.password == params[:password]
    session[:user_id]=user.id
    redirect "/"
  else
    redirect "/login"
end
end

post "/logout" do
  session[:user_id]= nil
  redirect "/login"
end

get "/show/:id" do
  if !session[:user_id]
		redirect "/login"
	else
@user = User.find(params[:id])
erb :'users/show'
end
end

get "/accounts" do
  if !session[:user_id]
		redirect "/login"
	else
  @users = User.all
  erb :'users/accounts'
end
end

get "/modify/:id" do
  @user = User.find(params[:id])
erb :'users/modify'
end


post "/update" do
  @user = User.find(session[:user_id])
  user=User.update(username: params[:username], password: params[:password])
  redirect "/"
end

post "/destroy/:id" do
@user = User.find(params[:id])
user= User.destroy(params[:id])
redirect "/signup"
end


# BLOG PORTION

get "/blogs" do
@blogs = Blog.all
erb :'blogs/index'
end

get "/blogs/create" do
@blogs = Blog.all
@user=User.find(session[:user_id])
erb :'blogs/create'
end

post "/blogs/create" do
  @blogs = Blog.all
  user= User.find(session[:user_id])
  blog=Blog.create(title: params[:title], content: params[:content], user_id: user.id)
  redirect "/blogs"
  erb :'blogs/create'
end
