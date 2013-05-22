# google_books_viewer
===================

To run the application on local host:

1. git clone https://github.com/sevenmaxis/google_books_viewer.git
2. cd google_books_viewer
3. bundle install
4. redis-server
5. rails server
6. go to http://0.0.0.0:3000


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
Time taken for tests:   1.324 seconds
Complete requests:      500
Failed requests:        0
Write errors:           0
Total transferred:      2769783 bytes
HTML transferred:       2581000 bytes
Requests per second:    377.57 [#/sec] (mean)
Time per request:       26.485 [ms] (mean)
Time per request:       2.649 [ms] (mean, across all concurrent requests)
Transfer rate:          2042.55 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       1
Processing:     7   26  25.7     19     183
Waiting:        2   21  25.8     16     183
Total:          7   26  25.7     19     183

Percentage of the requests served within a certain time (ms)
  50%     19
  66%     23
  75%     24
  80%     27
  90%     54
  95%     59
  98%    183
  99%    183
 100%    183 (longest request)
```

## Application is hosted on Heroku:
[http://google-books-viewer.herokuapp.com/](http://google-books-viewer.herokuapp.com/)

