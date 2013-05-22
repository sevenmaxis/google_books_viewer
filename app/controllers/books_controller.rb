class BooksController < ApplicationController
  respond_to :html

  def index
    @query, page = params[:query], (params[:page] || 1)

    @books, @total = Book.search(@query, page) do

      options = { 
        page: page.to_i, :api_key => Settings.api_key, :count => Settings.items_per_page 
      }
      result = GoogleBooks.search(@query, options, request.remote_ip)

      if (error = result.instance_variable_get(:@response)).present?
        logger.fatal "="*50
        logger.fatal "--- #{error.values.first['errors'].first['reason']}"
        logger.fatal "="*50
      end
      
      begin
        # walkaround for GoogleBooks gem
        # calling 'to_a' on emtpy collection raises an exception
        result.to_a
      rescue NoMethodError => e
        if e.message == "undefined method `each' for nil:NilClass"
          logger.fatal "GoogleBooks' error, the empty collection raises an exception"
          OpenStruct.new.tap do |os|
            os.to_a        = 0
            os.total_items = result.total_items
          end
        else
          raise e
        end
      else
        logger.info "#{result.inspect}"
        result
      end
    end

    logger.info "  total items: #{@total}"
    
    @books = Kaminari.paginate_array(@books, total_count: @total).page(page).per(5)
    respond_with @books
  end
end
