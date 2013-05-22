if Rails.env == "production"
  uri = URI.parse(ENV['REDISTOGO_URL'])
  $redis = Redis.new( host:     uri.host,
                      port:     uri.port,
                      password: uri.password)
else
  $redis = Redis.new( host:     Settings.redis.host, 
                      port:     Settings.redis.port,
                      password: Settings.redis.password )
end

