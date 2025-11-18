# django-gunicorn-docker

[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Felastic7327%2Fdjango-gunicorn-nginx-docker&count_bg=%2379C83D&title_bg=%23555555&title=Visitors&edge_flat=false)](https://hits.seeyoufarm.com)

Production-ready Django deployment with Gunicorn and high-performance Uvicorn workers in Docker.

## Tech Stack

- **Python**: 3.13
- **Django**: 5.2.8 (LTS)
- **Gunicorn**: 23.0.0
- **Uvicorn**: 0.38.0 (ASGI worker with uvloop and httptools)
- **Supervisor**: 4.3.0

## Features

- ASGI/WSGI compatible Django application
- High-performance Uvicorn workers with uvloop and httptools
- Gunicorn as HTTP server
- Supervisor for process management
- Docker Compose for easy deployment
- Development and production settings separation
- Security headers configured
- Lightweight architecture without nginx overhead

## Quick Start

### Development Environment

```bash
cd django_gunicorn
python3 manage.py runserver --settings=django_gunicorn.settings.development
```

### Docker Compose (Recommended)

```bash
# Build and start containers
docker-compose up --build

# Access the application at http://localhost:8000
# Admin interface at http://localhost:8000/admin
```

### Stop Containers

```bash
docker-compose down
```

## Manual Docker Build

### Build the Image

```bash
docker build -t django-gunicorn:latest .
```

### Run the Container

```bash
# Run on port 8000
docker run -it -d --rm -p 8000:8000 django-gunicorn:latest

# Access at http://localhost:8000
```

## Configuration

### Environment Settings

The application supports different environment configurations:

- **Development**: `django_gunicorn.settings.development`
- **Production**: `django_gunicorn.settings.product`

Set the environment using the `SERVICE_ARG` build argument:

```bash
docker build --build-arg SERVICE_ARG=product -t django-gunicorn:prod .
```

### Gunicorn Configuration

Located at `deploy_tools/gunicorn_conf.py`:

- Bind address: `0.0.0.0:8000`
- Worker class: Custom Uvicorn worker with uvloop and httptools
- Workers: `(CPU cores * 2) + 1`
- Max requests: 1000 (with jitter)
- Timeout: 15 seconds
- Keepalive: 62 seconds

## Project Structure

```
.
├── django_gunicorn/
│   ├── django_gunicorn/
│   │   ├── settings/
│   │   │   ├── settings_base.py
│   │   │   ├── development.py
│   │   │   └── product.py
│   │   ├── urls.py
│   │   ├── asgi.py
│   │   └── wsgi.py
│   ├── sample_app/
│   └── manage.py
├── deploy_tools/
│   ├── gunicorn_conf.py
│   ├── workers.py
│   ├── nginx.conf
│   └── supervisor.conf
├── requirements/
│   └── requirements.txt
├── Dockerfile
└── docker-compose.yaml
```

## Production Deployment

The production settings include:

- `DEBUG = False`
- Security middleware enabled
- Proper logging configuration
- Static and media files configuration

Make sure to:

1. Set `SECRET_KEY` via environment variable
2. Configure `ALLOWED_HOSTS` properly
3. Enable HTTPS settings if using SSL
4. Run migrations: `python manage.py migrate`
5. Collect static files: `python manage.py collectstatic`

## Reference

[Medium Article (Korean)](https://medium.com/@elastic7327/python%EA%B0%9C%EB%B0%9C%EC%9E%90-uwsgi%EB%A5%BC-%EB%B2%84%EB%A6%AC%EA%B3%A0-gunicorn%EC%9C%BC%EB%A1%9C-%EA%B0%88%EC%95%84%ED%83%80%EB%8B%A4-df1c95f220c5)

## License

This project is open source and available for educational purposes.
