FROM williamyeh/ansible:ubuntu16.04

ENV PASSLIB_VERSION="1.7.1"

ADD https://pypi.python.org/packages/25/4b/6fbfc66aabb3017cd8c3bd97b37f769d7503ead2899bf76e570eb91270de/passlib-${PASSLIB_VERSION}.tar.gz /usr/src/passlib-${PASSLIB_VERSION}.tar.gz
RUN cd /usr/src && tar xzf passlib-${PASSLIB_VERSION}.tar.gz && rm passlib-${PASSLIB_VERSION}.tar.gz
RUN cd /usr/src/passlib-${PASSLIB_VERSION} && python setup.py install

ENTRYPOINT [ "ansible-playbook" ]
