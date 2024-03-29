# django-gunicorn-nginx-docker Example
[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Felastic7327%2Fdjango-gunicorn-nginx-docker&count_bg=%2379C83D&title_bg=%23555555&title=Visitors&edge_flat=false)](https://hits.seeyoufarm.com)

https://medium.com/@elastic7327/python%EA%B0%9C%EB%B0%9C%EC%9E%90-uwsgi%EB%A5%BC-%EB%B2%84%EB%A6%AC%EA%B3%A0-gunicorn%EC%9C%BC%EB%A1%9C-%EA%B0%88%EC%95%84%ED%83%80%EB%8B%A4-df1c95f220c5

## Running the Development Environment
```
cd django_gunicorn

python3 manage.py runserver --settings=django_gunicorn.settings.development
```

## Running with Docker Compose Example
```
# Access via localhost (:80 port).

docker-compose up --build
```

## Building the Docker Image Example
```
docker build -t django_gunicorn:0.0.1 .
```

## Running the Built Docker Image Example
```
# Access via localhost:8080.
docker run -it -d --rm -p 8080:80 django_gunicorn:0.0.1
```

### If the container is running correctly, you will see the following screen at localhost:8080.

<img width="1285" alt="스크린샷 2019-06-17 오전 12 46 27" src="https://user-images.githubusercontent.com/16227780/59566313-62977580-9099-11e9-9151-9ee1f98da2de.png">
