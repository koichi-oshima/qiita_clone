class Api::V1::ArticlesController < Api::V1::ApiController
  def index
    articles = Article.all
    render json: articles
    binding.pry
  end
end