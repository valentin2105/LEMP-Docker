web_db:
   image: mariadb:latest
   restart: always
   volumes:
    - ./var/mysql:/var/lib/mysql
   environment:
    MYSQL_ROOT_PASSWORD: Abracadabraaa01

web_web:
  image: nginx
  restart: always
  ports:
    - 80:80
    - 443:443
  log_driver: syslog
  links:
    - web_fpm
  volumes:
    - ./www:/var/www/html:rw
    - ./etc/nginx/nginx.conf:/etc/nginx/nginx.conf:ro
    - ./var/log/nginx:/var/log/nginx
    - ./etc/letsencrypt:/etc/letsencrypt
    - ./etc/nginx/certs/dhparam.pem:/etc/nginx/certs/dhparam.pem

web_fpm:
  build: ./PHP-FPM/
  image: fpm-7.0.5
  restart: always
  links:
    - web_db:mysql
  volumes:
    - ./www:/var/www/html
