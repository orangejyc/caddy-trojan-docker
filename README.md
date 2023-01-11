# caddy-trojan-docker

caddy 下载文件
https://github.com/lxhao61/integrated-examples/releases/download/20220507/caddy_linux_amd64.tar.gz


## docker 运行
docker build -t orangejyc/caddy-trojan .

docker run -d -p 80:80 -p 443:443 -e MY_DOMAIN= -e MY_PWD orangejyc/caddy-trojan


## systemctl 运行

cp caddy /usr/bin
chmod +x /usr/bin/caddy

mdkir -vp /var/caddy

mkdir -vp /var/www/html

mkdir -vp /var/log/caddy

mkdir -vp /etc/caddy

cp Caddyfile-trojan-naive /etc/caddy/Caddyfile

cp index.html /var/www/html/

修改Caddyfile域名用户名密码

cp caddy.service /etc/systemd/system/

systemctl daemon-reload 

systemctl start caddy
