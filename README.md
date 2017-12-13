# ndocker-amavisd
An amavisd docker image for use with nomad

This contains a slightly patched version of amavisd that produces clean logs.
It has JSON formatted logging enabled and ready for structured logging.
However, amavis is a strange beast. Most log lines are not formatted in JSON, but it will produce a single line that contains all fields needed in JSON format.

It will read user preferences from consul if "amavis/user_prefs" is available in the K/V store in consul and will restart amavisd if those preferences are changed.

# ENVIRONMENT VARIABLES
Env var | Description | Notes
---|---|---
AMAVIS_MYDOMAIN | The domain amavis is using |
AMAVIS_MYHOSTNAME | The hostname reported by amavisd |
AMAVIS_ACL | Space separated list of cidr addresses that are allowed to connect to amavis |
POSTFIX_RETURN | Method to forward back to postfix | e.g. : "smtp:[192.168.1.100]:10025"
