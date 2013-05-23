class BooksController < ApplicationController

  respond_to :html

  def index
    @query, page = (params[:query] || 'The Great Gatsby'), (params[:page] || 1).to_i

    @books, @total, time = Book.search(@query, page) do

      retried = false

      # walkaround for GoogleBooks gem
      # calling 'to_a' on emtpy collection raises an exception
      # it happens because the Google Books API gives wrong total count
      # from privous request, but now we know the correct count
      begin
        options = { page: page, :count => Settings.per_page }
        (result = GoogleBooks.search(@query, options, Settings.ip)).to_a

      rescue NoMethodError => e
        
        if e.message == "undefined method `each' for nil:NilClass"
          logger.fatal "GoogleBooks' error, the empty collection raises an exception"
          
          if retried
            raise e            
          else
            retried = true
            max_page = (result.total_items - 1) / Settings.per_page + 1
            page = max_page if page > max_page
            retry
          end
        end
      end
      
      result
    end

    @books = Kaminari.paginate_array(@books, total_count: @total).page(page).per(Settings.per_page)

    fresh_when etag: etag_for(@books, layout: 'application.html.haml', view: 'books/index.html.haml'), 
               :last_modified => time, 
               :public => true
  end
end
