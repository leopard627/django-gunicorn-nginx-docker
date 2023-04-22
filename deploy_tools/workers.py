from uvicorn.workers import UvicornWorker as BaseUvicornWorker


class CustomUvicornWorker(BaseUvicornWorker):
    CONFIG_KWARGS = {"loop": "uvloop", "http": "httptools", "lifespan": "off"}
