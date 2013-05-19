class Book

  def self.search(query, page=1)
    key = "#{query}:#{page}"
    if result = $redis.get(key)
      result = Marshal.load(result)
    else
      result = yield
      result = [result.to_a, result.total_items]
      $redis.setex(key, Settings.redis.ttl, Marshal.dump(result))
    end
    # Format of result
    # [collections, total_items]
    result
  end
end