FROM stakater/base-centos:7

LABEL name="A rsyslog image on CentOS" \    
      maintainer="Stakater <stakater@aurorasolutions.io>" \
      vendor="Stakater" \
      release="1" \
      summary="A rsyslog image based on CentOS" 

ENV PID_DIR /tmp/pidDir

USER root

RUN  yum -y install rsyslog && \
	 yum clean all && \
	 echo "" > /etc/rsyslog.d/listen.conf && \
	 mkdir -p ${PID_DIR} && \
	 chmod 777 ${PID_DIR}

COPY rsyslog.conf /etc/rsyslog.conf

EXPOSE 1514

# Again using non-root user i.e. stakater as set in base image
USER 10001

CMD ["sh", "-c", "/usr/sbin/rsyslogd -i ${PID_DIR}/pid -n"]