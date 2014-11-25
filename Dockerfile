FROM dockerfile/java:oracle-java7
MAINTAINER Victor Pikula "victor@pikula.com"

VOLUME /hybris

RUN echo "#!/bin/bash\n. ./setantenv.sh\nant -Dinput.template=develop clean all" > /data/hybris/hybris/bin/platform/build.sh && chmod u+x /data/hybris/hybris/bin/platform/build.sh
RUN cd /data/hybris/hybris/bin/platform && ./build.sh 
RUN chmod u+x /data/hybris/hybris/bin/platform/hybrisserver.sh
RUN echo "127.0.0.1 `hostname`" > /etc/hosts
RUN echo "#!/bin/bash\n. ./setantenv.sh\nant initialize" > /data/hybris/hybris/bin/platform/init.sh
RUN chmod u+x /data/hybris/hybris/bin/platform/init.sh
RUN cd /data/hybris/hybris/bin/platform && ./init.sh
CMD /data/hybris/hybris/bin/platform/hybrisserver.sh

EXPOSE 9001