class BooksController < ApplicationController
  respond_to :html

  def index
    @query, page = params[:query], params[:page]
    
    @books = Book.search(@query, page) do
      GoogleBooks.search(@query, { page: page })
    end

    respond_to @books
  end
end
