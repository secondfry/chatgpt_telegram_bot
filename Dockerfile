FROM python:3.8-slim

RUN \
  set -eux; \
  apt-get update; \
  DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
  # required by the bot
  python3-yaml python3-pymongo ffmpeg \
  # debugging helpers
  nano ripgrep \
  ; \
  rm -rf /var/lib/apt/lists/*

RUN pip3 install -U pip && pip3 install -U wheel && pip3 install -U setuptools==59.5.0
COPY ./requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && rm -r /tmp/requirements.txt

COPY . /code
WORKDIR /code

CMD ["bash"]

