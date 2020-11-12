# Nginx and certbox

Setting up nginx to act as reverse proxy for applications running
inside docker containers.
Using certbox to generate letsencrypt certificates for the applications.

### Nginx

We want nginx to drop connection to domains that are not handled by a 
vhost and we want to proxy to the docker container when the domain matches.

-> server configuration for the `default` file in `/etc/nginx/sites-available/`

```
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    #return 301 https://$host$request_uri;
    return 444;
}
```

-> server configuration for the domain bla.foo.net with application running at 
127.0.0.1 on port 8080.

```
server {
    listen 80;
    listen [::]:80;

    server_name bla.foo.net;

    access_log /var/log/nginx/music.hebus.net.access.log;
    error_log /var/log/nginx/music.hebus.net.error.log;

    location / {
        proxy_pass http://127.0.0.1:8080;
    }
}
```

The configuration is listening on HTTP but certbot will configure to do a 
redirect to HTTPS.

### Certbot

In order for letsencrypt to get confirmation that you own the domain, DNS A record
for the domain need to be configured to point to the server.

-> install the certbox nginx plugin
```bash
$ sudo apt install python3-certbot-nginx
```

-> obtain certificate for domain bla.foo.net
```bash
$ sudo certbot --nginx -d bla.foo.net -d www.bla.foo.net
```

Certbox nginx plugin will then generate the certificate, update the nginx server
configuratin matching the domain and restart nginx

The auto renewal cron job should be created too.

-> to check the renewal process, execute a dry-run
```bash
$ sudo certbot renew --dry-run
```

