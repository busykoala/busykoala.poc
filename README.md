# Make Plone Great Again

This is a proof of concept project to setup Plone without buildout.

## Setup Project

```
# install
poetry install

# symlink pkg into lib
ln -s /path/to/here/busykoala <lib-path>/busykoala
# use this to get the lib path
poetry run python -c "import setuptools as _; print('/'.join(_.__path__[0].split('/')[:-1]))"

# create instance
poetry run mkwsgiinstance -d instance -u admin:admin

# add the following line to instance/etc/site.zcml
<include package="busykoala.poc" />
```

## Run

```
# run instance
poetry run runwsgi -v ./etc/zope.ini
```

## Production Environment

According to https://zope.readthedocs.io/en/latest/zopebook/ZEO.html#installing-and-running-zeo
the Docker image provided could be in a ZEO server/client setup with little
adaption. Hence one could spawn multiple of these using e.g. Kubernetes.
The ZODB folders would have to be persisted using cloud storage in this
scenario. Most probably there would be another container with nginx and one
with Varnish before being exposed to the internet.

## Advantages of this setup

- It is very fast to install/uninstall packages
- Using Minikube, k3s or similar it is very easy to reproduce the production
  environment locally.
- The server setup is very easy and has the same requirements for each
  instance.
- The ZEO clients are very easily scalable by just increasing the replica size
  in kubernetes.
- The poetry lock file can be used to pin packages (if packages are not
  installed all at once using "poetry add plone" like I did for demo purposes)
