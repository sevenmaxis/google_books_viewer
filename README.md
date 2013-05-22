google_books_viewer
===================

To run the application on local host:

1. git clone https://github.com/sevenmaxis/google_books_viewer.git
2. cd google_books_viewer
3. bundle install
4. redis-server
5. rails server
6. go to http://0.0.0.0:3000

To see the perfomance of application run this command:

```ruby
rspec --tag performance
```

On my computer it makes 5000 requests in less then 30 seconds