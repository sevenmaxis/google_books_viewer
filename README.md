# google_books_viewer
===================

To run the application on local host:

1. git clone https://github.com/sevenmaxis/google_books_viewer.git
2. cd google_books_viewer
3. bundle install
4. rails server
5. go to http://0.0.0.0:3000


## Performance on local host
``` sh
megas@megas:~/Work/google_books_viewer$ ab -n 500 -c 10 http://127.0.0.1:3000/ 
This is ApacheBench, Version 2.3 <$Revision: 655654 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient)
Completed 100 requests
Completed 200 requests
Completed 300 requests
Completed 400 requests
Completed 500 requests
Finished 500 requests


Server Software:        thin
Server Hostname:        127.0.0.1
Server Port:            3000

Document Path:          /
Document Length:        5162 bytes

Concurrency Level:      10
Time taken for tests:   0.260 seconds
Complete requests:      500
Failed requests:        0
Write errors:           0
Total transferred:      2668500 bytes
HTML transferred:       2581000 bytes
Requests per second:    1926.40 [#/sec] (mean)
Time per request:       5.191 [ms] (mean)
Time per request:       0.519 [ms] (mean, across all concurrent requests)
Transfer rate:          10040.21 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.5      0       5
Processing:     1    5   7.8      4      60
Waiting:        0    4   7.7      3      58
Total:          1    5   7.8      4      60

Percentage of the requests served within a certain time (ms)
  50%      4
  66%      4
  75%      5
  80%      5
  90%      5
  95%      7
  98%     58
  99%     59
 100%     60 (longest request)
```

## Application is hosted on Heroku:
[http://google-books-viewer.herokuapp.com/](http://google-books-viewer.herokuapp.com/)

