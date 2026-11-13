"""Compatibility wrappers for the shared molecular-utilities logger."""

import logging
from molecular_utilities.logging import configure_logging as _configure_logging
from molecular_utilities.logging import get_logger as _get_logger

LOGGER_NAME = "sdf_downloader"


def get_logger(name):
    return _get_logger(name, namespace=LOGGER_NAME)


def configure_logging(level=logging.INFO, stream=None):
    _configure_logging(level=level, stream=stream, namespace=LOGGER_NAME)
