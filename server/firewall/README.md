Simple firewall script that sets IPTABLE policies

Configure the TCP_SERVICES / UDP_SERVICES / REMOTE_TCP_SERVICES / REMOTE_UDP_SERVICES vars according to your needs
Copy the file in /etc/init.d/
Run:
sudo update-rc.d firewall.sh defaults 20
sudo service firewall start

Or if you want to go the SystemD way:
Copy the firewall.service file in /etc/systemd/system
Start the service by running:
sudo systemctl start firewall.service

