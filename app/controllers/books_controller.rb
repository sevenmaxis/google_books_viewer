class BooksController < ApplicationController
  respond_to :html

  def index
    @query, page = params[:query], params[:page]
    page = page ? page.to_i : 1

    @books, @total = Book.search(@query, page) do
      # walkaround for GoogleBooks gem
      # calling 'to_a' on emtpy collection raises an exception
      result = GoogleBooks.search(@query, { page: page })
      begin
        result.to_a
      rescue NoMethodError => e
        if e.message == "undefined method `each' for nil:NilClass"
          Object.new.tap do |object|
            class << object
              def to_a;        0                  end
              def total_items; result.total_items end
            end
          end
        else
          raise e
        end
      else
        result
      end
    end
    
    @books = Kaminari.paginate_array(@books, total_count: @total).page(page).per(5)
    respond_with @books
  end
end
