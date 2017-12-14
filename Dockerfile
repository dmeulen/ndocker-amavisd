FROM alpine:3.6

MAINTAINER Danny van der Meulen <danny@cb750k6.nl>

ENV \
  ALPINE_MIRROR="nl.alpinelinux.org" \
  ALPINE_VERSION="v3.6" \
  CONSUL_TEMPLATE_VERSION=0.19.4 \
  APK_ADD="" \
  APK_ADD_PERM="curl busybox amavisd-new spamassassin perl-net-cidr-lite razor perl-mail-spf make unzip p7zip" \
  AMAVIS_MYDOMAIN=\
  AMAVIS_MYHOSTNAME=\
  AMAVIS_ACL=\
  POSTFIX_RETURN=

EXPOSE 10024

WORKDIR /

RUN \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/main" > /etc/apk/repositories && \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/community" >> /etc/apk/repositories && \
  apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add ${APK_ADD} ${APK_ADD_PERM} && \
  curl -L https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o /tmp/consul-template.zip && \
  unzip /tmp/consul-template.zip -d /usr/bin && \
  mkdir -p /var/spool/amavis/tmp && \
  mkdir -p /var/spool/amavis/db && \
  mkdir /run/amavis && \
  chown -R amavis:amavis /var/spool/amavis /run/amavis && \
  apk --purge del ${APK_ADD} && \
  rm -rf \
    /tmp/* \
    /var/cache/apk/*

COPY rootfs/ /

CMD ["/init/run.sh"]
