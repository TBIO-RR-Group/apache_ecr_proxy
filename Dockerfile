FROM ubuntu:22.04

RUN apt-get upgrade -y && apt-get update -y
RUN apt-get install nano unzip curl apache2 -y
RUN ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy_http.load /etc/apache2/mods-enabled/
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
ADD ports.conf /etc/apache2/ports.conf
ADD default-ssl.confTEMPLATE /etc/apache2/sites-available/default-ssl.confTEMPLATE
RUN unlink /etc/apache2/sites-enabled/000-default.conf
RUN ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/
ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh", "443"]
