max_stale = "1m"

template {
  source = "/etc/ndocker/amavisd.conf.tpl"
  destination = "/etc/amavisd.conf"
}

template {
  source = "/etc/ndocker/user_prefs.tpl"
  destination = "/etc/mail/spamassassin/user_prefs"
}

exec {
  command = "amavisd -c /etc/amavisd.conf foreground"
  splay = "60s"
}
