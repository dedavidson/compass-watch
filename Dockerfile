FROM alpine:3.4
MAINTAINER Duncan Davidson

RUN apk update && apk upgrade && apk add ruby ruby-irb ruby-rdoc

COPY GlobalSignRootCA.pem /usr/lib/ruby/2.3.0/rubygems/ssl_certs

RUN apk --update add --virtual build-dependencies build-base libffi-dev linux-headers ruby-dev && \
	gem install listen compass compass-core compass-normalize rgba_png toolkit \
	breakpoint singularitygs susy sass-globbing oily_png --no-rdoc --no-ri && \
	apk del build-dependencies && \
	rm -rf /var/cache/apk/*

VOLUME /src

WORKDIR /src

ENTRYPOINT [ "compass" ]