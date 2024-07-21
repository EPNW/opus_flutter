FROM ubuntu:noble

# Install dependencies
RUN apt-get update \
	&& DEBIAN_FRONTENTD="noninteractive" apt-get install -y --no-install-recommends \
	apt-transport-https \
	wget \
	gnupg \
	ca-certificates \
	git \
	autoconf \
	automake \
	libtool \
	gcc \
	make \
	mingw-w64

# Clone opus
WORKDIR /app
RUN git clone --branch v1.5.2 https://github.com/xiph/opus.git
WORKDIR /app/opus

# Build opus using Windows cross compile
RUN ./autogen.sh \
	&& ./configure --host=x86_64-w64-mingw32 --disable-extra-programs --disable-doc --enable-shared \
	&& make \
	&& mv ./.libs/libopus-0.dll /app/libopus.x64.dll.blob \
	&& make clean
RUN ./configure --host=i686-w64-mingw32 --disable-extra-programs --disable-doc --enable-shared \
	&& make \
	&& mv ./.libs/libopus-0.dll /app/libopus.x86.dll.blob \
	&& make clean
WORKDIR /app