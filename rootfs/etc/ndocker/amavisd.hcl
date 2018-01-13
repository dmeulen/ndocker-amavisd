max_stale = "1m"

template {
  source = "/etc/ndocker/amavisd.conf.tpl"
  destination = "/etc/amavisd.conf"
}

template {
  source = "/etc/ndocker/local.tpl"
  destination = "/etc/mail/spamassassin/local.cf"
}

exec {
  command = "amavisd -c /etc/amavisd.conf foreground"
  splay = "60s"
}
