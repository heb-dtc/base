FROM ubuntu:16.04

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y git wget openjdk-8-jdk openssh-server

RUN echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config
EXPOSE 22

ENV USER heb
RUN useradd --create-home $USER
RUN echo heb:heb | chpasswd
USER $USER

RUN mkdir /home/heb/.ssh
RUN echo LANG=en_US.UTF-8 >> /home/heb/.ssh/environment
RUN echo LC_ALL=en_US.UTF-8 >> /home/heb/.ssh/environment
RUN echo LANGUAGE=en_US:en >> /home/heb/.ssh/environment

CMD ["/bin/bash"]
