FROM ubuntu:16.04

RUN apt update && apt install -y \
git \
python-pip \
python3-pip python3-dev \
sshpass \
openssh-client

RUN git clone https://github.com/ansible/ansible.git --recursive /usr/src/ansible && \
cd /usr/src/ansible && \
pip install -r requirements.txt

ENV PASSLIB_VERSION="1.7.1"
ADD https://pypi.python.org/packages/25/4b/6fbfc66aabb3017cd8c3bd97b37f769d7503ead2899bf76e570eb91270de/passlib-${PASSLIB_VERSION}.tar.gz /usr/src/passlib-${PASSLIB_VERSION}.tar.gz
RUN cd /usr/src && tar xzf passlib-${PASSLIB_VERSION}.tar.gz && rm passlib-${PASSLIB_VERSION}.tar.gz
RUN cd /usr/src/passlib-${PASSLIB_VERSION} && python setup.py install

ENV PATH="/usr/src/ansible/bin:/usr/src/ansible/test/runner:$PATH"
ENV PYTHONPATH="/usr/src/ansible/lib:$PYTHONPATH"
ENV MANPATH="/usr/src/ansible/docs/man:$MANPATH"

ENTRYPOINT [ "ansible-playbook" ]
