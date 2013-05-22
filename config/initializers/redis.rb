if Rails.env == "production"
  uri = URI.parse(ENV['REDISTOGO_URL'])
  $redis = Redis.new( host:     uri.host,
                      port:     uri.port,
                      passowrd: uri.passowrd)
else
  $redis = Redis.new( host:     Settings.redis.host, 
                      port:     Settings.redis.port,
                      passowrd: Settings.redis.passowrd )
end

