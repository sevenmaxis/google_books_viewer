class BooksController < ApplicationController
  respond_to :html

  def index
    @query, page = params[:query], params[:page]
    
    @books = Book.search(@query, page) do
      GoogleBooks.search(@query, { page: page.to_i })
    end
    
    respond_with @books
  end
end
