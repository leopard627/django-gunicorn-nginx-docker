[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Felastic7327%2Fdjango-gunicorn-nginx-docker&count_bg=%2379C83D&title_bg=%23555555&title=%EB%B0%A9%EB%AC%B8%EC%9E%90%EC%88%98&edge_flat=false)](https://hits.seeyoufarm.com)

# django-gunicorn-nginx-docker(지-유니콘 엔진엑스 예시)
https://medium.com/@elastic7327/python%EA%B0%9C%EB%B0%9C%EC%9E%90-uwsgi%EB%A5%BC-%EB%B2%84%EB%A6%AC%EA%B3%A0-gunicorn%EC%9C%BC%EB%A1%9C-%EA%B0%88%EC%95%84%ED%83%80%EB%8B%A4-df1c95f220c5

## 도커 컴포즈로 실행 Example
```
docker-compose up --build
```

## 도커 빌드 하는방법 Example
```
docker build -t django_gunicorn:0.0.1 .
```

## 빌드한 도커 이미지를 실행하는 방법  Example
```
# localhost:8080으로 확인 하실 수 있습니다.
docker run -it -d --rm -p 8080:80 django_gunicorn:0.0.1
```


### 정상적으로 컨테이너가 실행되었다면 localhost:8080에 아래와 같은 화면이 나올 것입니다.

<img width="1285" alt="스크린샷 2019-06-17 오전 12 46 27" src="https://user-images.githubusercontent.com/16227780/59566313-62977580-9099-11e9-9151-9ee1f98da2de.png">
