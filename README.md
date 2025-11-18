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

## Architecture

This project uses a simplified architecture without nginx:

```
Client → Gunicorn (port 8000) → Uvicorn Workers → Django App
```

**Why no nginx?**
- Simpler architecture with fewer moving parts
- Lower resource usage (memory and CPU)
- Easier to maintain and debug
- Gunicorn + Uvicorn workers provide excellent performance for most use cases
- For production with nginx, you can add it as a reverse proxy in front of this container

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
│   ├── gunicorn_conf.py    # Gunicorn configuration
│   ├── workers.py          # Custom Uvicorn worker
│   └── supervisor.conf     # Supervisor process manager config
├── requirements/
│   └── requirements.txt
├── Dockerfile
└── docker-compose.yaml
```

## Production Deployment

### Production Settings

The production settings (`django_gunicorn.settings.product`) include:

- `DEBUG = False`
- Security middleware enabled
- Proper logging configuration
- Static and media files configuration
- Security headers (X-Frame-Options, X-Content-Type-Options, etc.)

### Deployment Checklist

1. **Environment Variables**
   ```bash
   docker build --build-arg SERVICE_ARG=product -t django-gunicorn:prod .
   ```

2. **Security Configuration**
   - Set `SECRET_KEY` via environment variable
   - Configure `ALLOWED_HOSTS` with your domain
   - Enable HTTPS settings if using SSL/TLS

3. **Database Setup**
   ```bash
   docker exec <container-name> python manage.py migrate
   ```

4. **Static Files**
   ```bash
   docker exec <container-name> python manage.py collectstatic --noinput
   ```

5. **Optional: Add Nginx Reverse Proxy**

   For production with SSL termination and static file serving, you can add nginx as a reverse proxy:

   ```nginx
   server {
       listen 80;
       server_name yourdomain.com;

       location / {
           proxy_pass http://localhost:8000;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }
   ```

## Performance

With Gunicorn + Uvicorn workers (uvloop + httptools):

- **Response Time**: ~4-8ms average
- **Workers**: Auto-scaled based on CPU cores `(cores * 2) + 1`
- **Concurrent Connections**: 1000 per worker
- **Protocol**: HTTP/1.1 with keepalive

This setup provides excellent performance for most applications without the complexity of nginx.

## Reference

[Medium Article (Korean)](https://medium.com/@elastic7327/python%EA%B0%9C%EB%B0%9C%EC%9E%90-uwsgi%EB%A5%BC-%EB%B2%84%EB%A6%AC%EA%B3%A0-gunicorn%EC%9C%BC%EB%A1%9C-%EA%B0%88%EC%95%84%ED%83%80%EB%8B%A4-df1c95f220c5)

## License

This project is open source and available for educational purposes.
