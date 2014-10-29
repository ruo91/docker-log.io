#
# Dockerfile - Log.io
#
# - Build
# git clone https://github.com/ruo91/docker-log.io /opt/docker-log.io
# docker build --rm -t log.io /opt/docker-log.io
#
# - Run
# docker run -d --name="log.io" -h "log.io" -v /var/log:/var/log log.io

# 1. Base images
FROM     centos:centos6
MAINTAINER Yongbok Kim <ruo91@yongbok.net>

# 2. Change the repository
RUN sed -i 's/mirrorlist/\#mirrorlist/g' /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i 's/#baseurl\=http\:\/\/mirror.centos.org/baseurl\=http\:\/\/mirror.cdnetworks.com/g' /etc/yum.repos.d/CentOS-Base.repo

# 3. Add the epel, spacewalk, jpackage repository
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# 4. Installation a log.io
RUN yum install -y npm nodejs
RUN npm install -g log.io --user "root"

# 5. Add in the .log.io directory
ADD conf/harvester.conf		/root/.log.io/harvester.conf
ADD conf/log_server.conf		/root/.log.io/log_server.conf
ADD conf/web_server.conf		/root/.log.io/web_server.conf

# 6. Supervisor
RUN yum install -y python-setuptools && easy_install pip && pip install supervisor && mkdir /etc/supervisord.d
ADD conf/supervisord.conf /etc/supervisord.d/supervisord.conf

# 7. Port
EXPOSE 28778

# 8. Start supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.d/supervisord.conf"]