Apache configuration file

File should go into /etc/apache2/site-available 
Then symlink into /etc/apache2/site-enable

Generate key and certificate for HTTPS using openssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -sha256 -out <path-to-certficate> -keyout <path-to-key>
