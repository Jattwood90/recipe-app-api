FROM python:3.7-alpine
MAINTAINER Joe A

ENV PYTHONUNBUFFERED 1

# Install dependencies
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Setup directory structure - creates app folder, and blank app
RUN mkdir /app
WORKDIR /app
COPY ./app/ /app

#Security feature that prevents external root access
RUN adduser -D user
USER user