FROM ubuntu

LABEL version="1.0"
LABEL maintainer="dzirtbry@gmail.com"
LABEL description="Simple container to package AWS Lambda functions written in python"

RUN apt-get update && apt-get install -y \
    zip \
    python \
    python-pip


RUN pip install --upgrade \
    pip \
    virtualenv

VOLUME ["/data"]

COPY package_lambda.sh /tmp/

ENTRYPOINT /tmp/package_lambda.sh

