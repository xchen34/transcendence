apt update

apt install -y certbot python3-certbot-nginx

certbot --nginx -d yourserver.name -d yourserver.name

certbot renew --dry-run