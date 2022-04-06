FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install less cron emacs nano vim zip unzip curl apache2=2.4.29-1ubuntu4.22 -y
RUN ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/
RUN ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/ && sed -i 's/ssl-cert-snakeoil.pem/domain.crt/g' /etc/apache2/sites-enabled/default-ssl.conf && sed -i 's/private\/ssl-cert-snakeoil.key/certs\/domain.key/g' /etc/apache2/sites-enabled/default-ssl.conf && ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy_http.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy_http2.load /etc/apache2/mods-enabled/ && ln -s /etc/apache2/mods-available/proxy_ajp.load /etc/apache2/mods-enabled/
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
ADD default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf
#ADD apache2.conf /etc/apache2/apache2.conf
ADD auth_init.sh /
ADD auth_update.sh /
