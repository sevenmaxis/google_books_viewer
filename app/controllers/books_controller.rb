class BooksController < ApplicationController
  respond_to :html

  def index
    @query, page = params[:query], params[:page].to_i
    
    @books, total = Book.search(@query, page) do
      GoogleBooks.search(@query, { page: page })
    end

    @books = Kaminari.paginate_array(@books, total_count: total).page(page).per(5)

    respond_with @books
  end
end
