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

# 정상적으로 컨테이너가 실행되었는지 웹브라우저 또는 curl로 확인

<img width="1285" alt="스크린샷 2019-06-17 오전 12 46 27" src="https://user-images.githubusercontent.com/16227780/59566313-62977580-9099-11e9-9151-9ee1f98da2de.png">
