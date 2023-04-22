FROM python:3.11-slim-buster

LABEL maintainer="FOR_EVERY_ONE"

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    nginx \
    supervisor \
    sqlite3 \
    locales \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip setuptools

WORKDIR /project
COPY requirements/requirements.txt /project/
RUN pip3 install -r requirements.txt

COPY . /project/

ARG SERVICE_ARG=development
ENV DJANGO_SETTINGS_MODULE=django_gunicorn.settings.$SERVICE_ARG
ENV SERVICE_ENV=$SERVICE_ARG

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY deploy_tools/nginx.conf /etc/nginx/sites-available/default
COPY deploy_tools/supervisor.conf /etc/supervisor/conf.d/

EXPOSE 80
EXPOSE 443

CMD ["supervisord", "-n"]

