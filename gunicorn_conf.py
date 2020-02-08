import multiprocessing

name = 'django_gunicorn'
bind = 'unix:/project/django_gunicorn.sock'
workers = multiprocessing.cpu_count() * 2 + 1
keepalive = 32
worker_connections = 1000 * workers
worker_class = "gevent"
reload = True
loglevel = 'info'
logfile = '-'
spew = False

max_requests = 1000
max_requests_jitter = 50
graceful_timeout = 15
timeout = 15

BASE_DIR = "/project/django_gunicorn"
pythonpath = BASE_DIR
chdir = BASE_DIR

preload_app = False
