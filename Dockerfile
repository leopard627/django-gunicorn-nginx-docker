FROM python:3.13-slim-bookworm

LABEL maintainer="FOR_EVERY_ONE"

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
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

COPY deploy_tools/supervisor.conf /etc/supervisor/conf.d/

EXPOSE 8000

CMD ["supervisord", "-n"]

