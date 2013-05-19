class Book

  def self.search(query, page=1)
    key = "#{query}:#{page}"
    if result = $redis.get(key)
      result = Marshal.load(result)
    else
      result = yield.to_a
      $redis.setex(key, Settings.redis.ttl, Marshal.dump(result))
    end
    result
  end
end