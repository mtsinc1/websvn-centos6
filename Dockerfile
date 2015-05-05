# DOCKER-VERSION 0.6
FROM centos:centos6
MAINTAINER Tim Holloway <timh@mousetech.com>
ENV HTTP_PROXY=http://10.0.1.16:3128
ENV HTTPS_PROXY=http://10.0.1.16:3128
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN echo >>/etc/yum.conf "proxy=http://10.0.1.16:3128"
RUN yum -y install websvn websvn-selinux svn
ADD websvn.conf /etc/httpd/conf.d/websvn.conf
RUN echo >>/etc/websvn/config.php "\$config->addRepository('Mousetech', 'http://svn.mousetech.com/svn');"
RUN echo ServerName svn.mousetech.com:80 >>/etc/httpd/conf/httpd.conf

EXPOSE 80 443

#CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]
# 
CMD /usr/sbin/apachectl -D FOREGROUND
