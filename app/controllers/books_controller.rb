class BooksController < ApplicationController
  respond_to :html

  def index
    @query, page = (params[:query] || 'The Great Gatsby'), (params[:page] || 1).to_i

    @books, @total = Book.search(@query, page) do

      retried = false

      # walkaround for GoogleBooks gem
      # calling 'to_a' on emtpy collection raises an exception
      # it happens because the Google Books API gives wrong total count
      # from privous request, but now we know the correct count
      begin
        options = { page: page, :count => Settings.per_page }
        result = GoogleBooks.search(@query, options, Settings.ip)
        result.to_a

      rescue NoMethodError => e
        
        if e.message == "undefined method `each' for nil:NilClass"
          logger.fatal "GoogleBooks' error, the empty collection raises an exception"
          
          unless retried
            retried = true
            page = (result.total_items - 1) / Settings.per_page + 1
            retry
          else
            raise e
          end
        end
      end
      
      result
    end

    logger.info "  total items: #{@total}, page: #{page}"

    @books = Kaminari.paginate_array(@books, total_count: @total-1).page(page).per(Settings.per_page)
    respond_with @books
  end
end
