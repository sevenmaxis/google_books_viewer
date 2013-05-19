class Book

  def self.search(query, page=1)
    key = "#{query}:#{page}"
    if result = $redis.get(key)
      result = Marshal.load(result)
    else
      result = yield
      $redis.setex(key, Settings.redis.ttl, Marshal.dump(result.to_a))
    end
    result
  end
end