FROM ubuntu:latest
MAINTAINER baojk <bjklwr@outlook.com>

ENV UBUNTU 18.04

# 使用root用户
USER root

RUN apt-get update -qqy && apt-get install -y ca-certificates

RUN  echo "deb https://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse\n" > /etc/apt/sources.list \
 && echo "deb https://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse\n" >> /etc/apt/sources.list \
 && echo "deb https://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse\n" >> /etc/apt/sources.list \
 && echo "deb https://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse\n" >> /etc/apt/sources.list \
 && echo "deb https://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse\n" >> /etc/apt/sources.list

# 更新源,安装软件
#RUN apt-get update -qqy && apt-get install -qqy openjdk-8-jre
RUN apt-get update -qqy && apt-get install -qqy python3 python3-pip && pip3 install selenium
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qqy && apt-get install -qqy sudo xvfb language-pack-zh-hans fonts-arphic-* dbus xdotool
RUN /etc/init.d/dbus start

RUN export LANG="zh_CN.UTF-8"
RUN export LANGUAGE="zh_CN:zh:en_US:en"

# 添加并切换到bjk用户，此用户sudo无需密码
RUN useradd bjk --shell /bin/bash --create-home -U \
	&& echo "bjk ALL=(ALL)NOPASSWD: ALL" >> /etc/sudoers
USER bjk

WORKDIR /home/bjk
RUN mkdir -p workdir

COPY chromedriver.for79 /usr/bin/chromedriver
COPY google-chrome-stable_79.0.3945.88-1_amd64.deb /home/bjk/google-chrome-stable_79.0.3945.88-1_amd64.deb
RUN sudo dpkg -i google-chrome-stable_79.0.3945.88-1_amd64.deb || sudo apt-get install -qqy -f

COPY yahei.ttf /usr/share/fonts/TTF
COPY entrypoint.sh /home/bjk/entrypoint.sh
RUN sudo chmod +x entrypoint.sh
RUN sudo chmod 777 /usr/bin/chromedriver


ENTRYPOINT [ "sh", "-c", "./entrypoint.sh null null null" ]
