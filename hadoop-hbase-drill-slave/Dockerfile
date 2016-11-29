FROM sebge2/hadoop-hbase-slave:latest
MAINTAINER sgerard <sgerard@emasphere.com>

# move all configuration files into container
ADD files/* /tmp/

#install Drill 
RUN wget -q -o out.log -P /tmp  http://apache.mirrors.hoobly.com/drill/drill-1.8.0/apache-drill-1.8.0.tar.gz && \
tar xzf /tmp/apache-drill-1.8.0.tar.gz -C /usr/local && \
rm /tmp/apache-drill-1.8.0.tar.gz  && \
mv /usr/local/apache-drill-1.8.0 /usr/local/drill && \
mv /tmp/drill-override.conf /usr/local/drill/conf/drill-override.conf && \
cat /tmp/bashrc >> ~/.bashrc && \
rm /tmp/bashrc && \
mv /tmp/start-drill.sh /root/start-drill.sh && \
chmod ugo+x /root/start-drill.sh

EXPOSE 8047

