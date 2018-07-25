FROM stilliard/pure-ftpd:latest
LABEL maintainer="Maxime PELTE <maxime.pelte@gmail.com>"

RUN apt-get update && apt-get install nginx -y

RUN chown ftpuser:ftpgroup -R /usr/share/nginx/html

# RUN echo "events { }" > /etc/nginx/nginx.conf \
#   && echo "http {" >> /etc/nginx/nginx.conf \
#   && echo "server {" >> /etc/nginx/nginx.conf \
#   && echo "    root /usr/share/nginx/html;" >> /etc/nginx/nginx.conf \
#   && echo "    location / {" >> /etc/nginx/nginx.conf \
#   && echo "        autoindex on;" >> /etc/nginx/nginx.conf \
#   && echo "    }" >> /etc/nginx/nginx.conf \
#   && echo "}" >> /etc/nginx/nginx.conf \
#   && echo "}" >> /etc/nginx/nginx.conf

# pure-pw useradd jenkins -u ftpuser -d /usr/share/nginx/html -m && cat /etc/pure-ftpd/pureftpd.passwd
RUN echo 'jenkins:$6$td6wIt1kK7kgwQG0$1ak3Ft1mVZsPMtI/TP3QxfeAk6iMxTDvPp7f50M4uLWVvJUjNTW2lRDwMAJ3KHG4220xulx.vwmHUxhuRj2XN0:1000:1000::/usr/share/nginx/html/./::::::::::::' > /etc/pure-ftpd/pureftpd.passwd
RUN pure-pw mkdb

COPY run-nginx.sh /run-nginx.sh
RUN chmod +x /run-nginx.sh

CMD ["/run-nginx.sh"]

EXPOSE 21 80 30000-30009


