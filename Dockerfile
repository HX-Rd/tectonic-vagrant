FROM		alpine:latest
RUN			apk update && apk upgrade && \
			apk add \
    		py-crypto \
    		python \
    		tzdata \     		    		
    		py-pip \
    		bash \
    		sudo \
    		py-simplejson    		
RUN			rm -rf /var/cache/apk/*
RUN			mkdir -p /opt/bin && \
			ln -s /usr/bin/python /opt/bin/python
