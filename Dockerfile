FROM python:3.13-slim

WORKDIR /opt

RUN apt update  \
    && apt install -y --no-install-recommends make gcc libreadline-dev \
    && rm -rf /var/lib/apt

COPY . .

# Сборка kubsh
RUN make all
RUN make deb

# Установка deb
RUN apt update && apt install -y ./kubsh_1.0.0_amd64.deb

# Установка pytest
RUN pip install -r requirements.txt

# Создание VFS
RUN mkdir -p /opt/users

CMD ["bash"]
