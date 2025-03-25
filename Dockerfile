FROM debian:sid-slim
MAINTAINER Emily <info@emy.sh>

RUN apt-get update && apt-get install -y gdc-13 gcc dub git build-essential libtool automake pkg-config libusb-1.0-0-dev
RUN git clone https://github.com/Vogtinator/libnspire
RUN cd libnspire && autoreconf -f -i && ./configure --prefix=/usr && make && make install
COPY . /app
RUN cd /app && dub build
ENTRYPOINT ["/app/nspire-tools"]
