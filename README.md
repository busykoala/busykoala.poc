# Make Plone Great Again

This is a proof of concept project to setup Plone without buildout.
The current implementation is not very convincing yet but already is great
compared to using buildout.

## Setup Project

```
# install
poetry install

# symlink pkg into lib
ln -s /path/to/here/busykoala <lib-path>/busykoala
# use this to get the lib path
poetry run python -c "import setuptools as _; '/'.join(_.__path__[0].split('/')[:-1])"

# create instance
poetry run mkwsgiinstance
> [Directory]: .
> [Username]: admin
> [Password]: *****

# add the following line to instance/etc/site.zcml
<include package="busykoala.poc" />
```

## Run

```
# create instance
poetry run mkwsgiinstance
> [Directory]: .
> [Username]: admin
> [Password]: *****

# run instance
poetry run runwsgi -v ./etc/zope.ini
```

## Init a similar project

```
poetry init
poetry add Plone  # and Paste
```
