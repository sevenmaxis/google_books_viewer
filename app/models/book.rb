class Book

  def self.search(query, page=1)
    key = "#{query}:#{page}"
    
    unless result = Rails.cache.read(key)
      result = yield
      result = [result.to_a, result.total_items, DateTime.current]
      Rails.cache.write(key, result)
    end    
    # Format of result
    # [collections, total_items, time]
    result
  end
end