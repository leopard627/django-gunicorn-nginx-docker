# django-gunicorn-nginx-docker

# 도커 빌드 하는방법 Example
```
docker build -t django_gunicorn:0.0.1
```

# 빌드한 도커 이미지를 실행하는 방법  Example
```
# localhost:8080으로 확인 하실 수 있습니다.
docker run -it -d --rm -p 8080:80 django_gunicorn:0.0.1
```
