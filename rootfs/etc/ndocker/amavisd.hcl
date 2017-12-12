max_stale = "1m"

template {
  source = "/etc/ndocker/amavisd.conf.tpl"
  destination = "/etc/amavisd.conf"
}

exec {
  command = "amavisd -c /etc/amavisd.conf foreground"
  splay = "30s"
}
