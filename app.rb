require_relative 'config/environment'
DB = Sequel.connect('mysql2://root:@localhost/code_test')

class App < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views'
  
  get '/' do
    erb :home
  end

  get '/comments' do
    @search_terms = params[:search_terms]

    @comments = DB[:comments].where('text LIKE ?', "%#{@search_terms}%").reverse(:createdAt)
    @comments = add_articles(@comments)
    
    erb :results
  end

  def add_articles(sequel_comments)
    sequel_comments.map do |c|
      article = DB[:articles].where(:id => c[:articleId]).first
      c[:title] = article[:title]
      c[:url] = article[:url]
      c
    end
  end

  def add_commas(integer)
    integer.to_s.reverse.scan(/\d{3}|.+/).join(",").reverse
  end 

end