Dockerfile - Log.io
==============================
Monitor any local log files in real time.

### Run ###
```
root@ruo91:~# docker run -d --name="log.io" -h "log.io" -v /var/log:/var/log ruo91/log.io
```
or

### Build ###
```
root@ruo91:~# git clone https://github.com/ruo91/docker-log.io /opt/docker-log.io
root@ruo91:~# docker build --rm -t log.io /opt/docker-log.io
```

### Run ###
```
root@ruo91:~# docker run -d --name="log.io" -h "log.io" -v /var/log:/var/log log.io
```
```
root@ruo91:~# docker inspect -f '{{ .NetworkSettings.IPAddress }}' log.io
172.17.0.30
```

### Web UI ###
Log.io: http://172.17.0.30:28778

ID: admin , Pass: log.io
![Log.io][1]

[1]: http://cdn.yongbok.net/ruo91/img/log.io/log.io.png