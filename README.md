# caddy-trojan-docker

caddy 下载文件
https://github.com/lxhao61/integrated-examples/releases/download/20220507/caddy_linux_amd64.tar.gz


docker build -t orangejyc/caddy-trojan .

docker run -d -p 80:80 -p 443:443 -e MY_DOMAIN= -e MY_PWD orangejyc/caddy-trojan
