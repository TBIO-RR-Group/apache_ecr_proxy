FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install less emacs nano vim zip unzip curl apache2=2.4.29-1ubuntu4.22 -y
RUN ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy_http.load /etc/apache2/mods-enabled/
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
ADD default-ssl.confTEMPLATE /etc/apache2/sites-available/default-ssl.confTEMPLATE
RUN ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/
ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
