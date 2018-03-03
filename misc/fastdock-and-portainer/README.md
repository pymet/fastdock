> TODO: add proper readme

```
apt install apache2-utils
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl.key -out ssl.crt
htpasswd -c htpasswd USERNAME
```
