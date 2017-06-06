FROM ubuntu:trusty
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

RUN apt-get update && apt-get install -y dnsmasq

USER root
CMD ["dnsmasq", "--no-daemon"]

#perform cleanup to reduce image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*&&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -v
