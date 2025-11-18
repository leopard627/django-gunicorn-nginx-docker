import multiprocessing
from deploy_tools.workers import CustomUvicornWorker

name = "django_gunicorn"
bind = "0.0.0.0:8000"
workers = multiprocessing.cpu_count() * 2 + 1
keepalive = 62
worker_connections = 1000 * workers
worker_class = "deploy_tools.workers.CustomUvicornWorker"
reload = True
loglevel = "INFO"
logfile = "-"
spew = False
lifespan = "off"

capture_output = True

max_requests = 1000
max_requests_jitter = 50
graceful_timeout = 15
timeout = 15

BASE_DIR = "/project/django_gunicorn"
pythonpath = BASE_DIR
chdir = BASE_DIR

preload_app = False
