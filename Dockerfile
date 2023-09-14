FROM node

RUN npm install -g crontab-ui pm2
RUN apt-get update && \
    apt-get install -y \
    cron \
    python3 \
    python3-pip \
    wget \
    curl

ENV CRON_PATH=/etc/cron.d
ENV CRON_DB_PATH=/crontab-ui-data
ENV CRON_IN_DOCKER=true
ENV HOST=0.0.0.0
ENV PORT=8000

VOLUME ["/scripts"]
VOLUME ["/etc/cron.d"]
VOLUME ["/crontab-ui-data"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo "service cron start && pm2 start crontab-ui --no-daemon" > /startup
RUN chmod 755 /startup

CMD [ " startup " ]
