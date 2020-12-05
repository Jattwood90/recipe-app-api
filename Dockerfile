FROM python:3.7-alpine
MAINTAINER Joe A

ENV PYTHONUNBUFFERED 1

# Install dependencies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
		gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Setup directory structure - creates app folder, and blank app
RUN mkdir /app
WORKDIR /app
COPY ./app/ /app

#Security feature that prevents external root access
RUN adduser -D user
USER user