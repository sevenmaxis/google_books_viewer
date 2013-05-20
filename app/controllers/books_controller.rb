class BooksController < ApplicationController
  respond_to :html

  def index
    @query, page = params[:query], params[:page]
    page = page ? page.to_i : 1

    @books, @total = Book.search(@query, page) do
      GoogleBooks.search(@query, { page: page })
    end
  
  rescue StandardError
    flash[:error] = "Something went wrong on Google Book API"
    @books = []
  ensure
    @books = Kaminari.paginate_array(@books, total_count: @total).page(page).per(5)
    respond_with @books
  end
end
