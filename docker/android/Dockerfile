FROM ubuntu:16.04

#create user
ENV USER droid
RUN useradd --create-home $USER
RUN echo droid:droid | chpasswd

#install needed packets
RUN dpkg --add-architecture i386
RUN apt-get update \
    && apt-get install -y git wget openjdk-8-jdk libz1:i386 libncurses5:i386 libbz2-1.0:i386 libstdc++6:i386 openssh-server ant

#switch to user
USER $USER
WORKDIR /home/droid

#fetch android ndk, unpack it and install it 
RUN wget http://dl.google.com/android/ndk/android-ndk-r10c-linux-x86_64.bin
RUN chmod +x android-ndk-r10c-linux-x86_64.bin
RUN ./android-ndk-r10c-linux-x86_64.bin
RUN ln -s android-ndk-r10c android-ndk
RUN rm -f android-ndk-r10c-linux-x86_64.bin

#fetch android sdk and unpack it
RUN wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz \
    && tar xzf android-sdk.tgz \
    && rm -f android-sdk.tgz

#update PATH to have android tooling available
ENV ANDROID_HOME /home/droid/android-sdk-linux
ENV ANDROID_NDK_HOME /home/droid/android-ndk
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

#update android SDK and download additional libraries needed to build 
#splitting stuff seems to workaround https://code.google.com/p/android/issues/detail?id=4410
RUN (while true; do sleep 1; echo y; done) | /home/droid/android-sdk-linux/tools/android update sdk -a --no-ui --filter tools
RUN (while true; do sleep 1; echo y; done) | /home/droid/android-sdk-linux/tools/android update sdk -a --no-ui --filter platform-tools
RUN (while true; do sleep 1; echo y; done) | /home/droid/android-sdk-linux/tools/android update sdk -a --no-ui --filter extra-android-support,extra-android-m2repository,extra-google-google_play_services,extra-google-m2repository
RUN (while true; do sleep 1; echo y; done) | /home/droid/android-sdk-linux/tools/android update sdk -a --no-ui --filter android-24,android-23,android-22,android-21,android-20,android-19
RUN (while true; do sleep 1; echo y; done) | /home/droid/android-sdk-linux/tools/android update sdk -a --no-ui --filter build-tools-24.0.0,build-tools-23.0.3,build-tools-23.0.2,build-tools-23.0.1,build-tools-23.0.0,build-tools-22.0.1,build-tools-22.0.0,build-tools-21.1.1,build-tools-21.1.0,build-tools-21.0.2,build-tools-21.0.1,build-tools-21.0.0,build-tools-20.0.0

RUN mkdir -p /home/droid/workspace
WORKDIR /home/droid/workspace
