
require_relative "../../config/environment"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  #showing new form for creating an article
  get "/articles/new" do
    erb :new
  end

  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  #creating a new article
  post "/articles" do
    newArticle = Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{newArticle.id}"
  end

  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  #update action
  patch "/articles/:id" do
    article = Article.find(params[:id])
    article.update(title: params[:title], content: params[:content])
    redirect "/articles/#{article.id}"
  end

  delete "/articles/:id" do
    article = Article.find(params[:id])
    article.delete
    redirect "/articles"
  end
end
