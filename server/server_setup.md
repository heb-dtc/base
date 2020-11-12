# Setting up private server on Debian10 jessie

Once the OS has been installed these are the first things to setup on the 
server:

- create a new user
- grant admin priviledges to the user
- setting up a firewall
- securing SSH access
- setting up fail2ban

### USER

-> create a new user
```bash
$ adduser bob
```

-> grant admin privilege to user
```bash
$ usermod -aG sudo bob
```

### FIREWALL

-> install ufw and enables ssh rules
```bash
$ sudo apt-get ufw
$ sudo ufw allow OpenSSH
$ sudo ufw allow SSH
$ sudo ufw enable
$ sudo ufw status
```

### SSH

First copy your ssh key from your local machine to the server

-> for a key called id_rsa and user named bob
```bash
$ ssh-copy-id -i .ssh/id_rsa bob@server
```

Then on the server we want to disable root login, 
disable password authentication and change the ssh port.

The configuration file to edit is `/etc/ssh/sshd_config`.

-> add the rules
```bash
PasswordAuthentication yes
PermitRootLogin no
Port 9876
```

### FAIL2BAN

-> install it
```bash
$ sudo aptitude install fail2ban
```

-> create local config
```bash
$ sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

-> start the service
```bash
sudo service fail2ban restart
```





