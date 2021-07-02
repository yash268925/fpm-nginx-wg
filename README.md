# docker-fpm-nginx

nginx + php-fpm (alpine base)

## これは何

PHPが動くnginxのコンテナ(waggo6向け)

## 用途

開発するときの使い捨てコンテナに

```zsh
docker run -it --rm -v $(pwd):/var/www -p 8080:80 yash268925/fpm-nginx-wg
```
