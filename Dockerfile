FROM python:3.8-buster
MAINTAINER info@busykoala.ch

COPY busykoala /app/busykoala
COPY poetry.lock /app/poetry.lock
COPY pyproject.toml /app/pyproject.toml
WORKDIR /app

RUN pip install poetry
RUN poetry install

RUN ln -s /app/busykoala `poetry run python -c "import setuptools as _; print('/'.join(_.__path__[0].split('/')[:-1]) + '/busykoala')"`

RUN poetry run mkwsgiinstance -d instance -u admin:admin
RUN sed '/include/a \ \ <include package="busykoala.poc"\ \/>' instance/etc/site.zcml
RUN cat instance/etc/site.zcml
RUN ls instance
RUN ls instance/var/log

EXPOSE 8080
CMD poetry run runwsgi -v instance/etc/zope.ini
