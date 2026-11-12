"""Console logging shared by the downloader's modules."""

import logging
import sys

LOGGER_NAME = "sdf_downloader"


def get_logger(name):
    return logging.getLogger(f"{LOGGER_NAME}.{name}")


def configure_logging(level=logging.INFO, stream=None):
    logger = logging.getLogger(LOGGER_NAME)
    if not any(getattr(handler, "_sdf_downloader_handler", False) for handler in logger.handlers):
        handler = logging.StreamHandler(stream if stream is not None else sys.stderr)
        handler.setFormatter(logging.Formatter("%(levelname)s %(name)s: %(message)s"))
        handler._sdf_downloader_handler = True
        logger.addHandler(handler)
    logger.setLevel(level)
    logger.propagate = False
