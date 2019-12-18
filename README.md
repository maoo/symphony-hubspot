[![FINOS - Archived](https://cdn.jsdelivr.net/gh/finos/contrib-toolbox@master/images/badge-archived.svg)](https://finosfoundation.atlassian.net/wiki/display/FINOS/Archived)
[![Dependencies](https://www.versioneye.com/user/projects/58cc3b2fdcaf9e0045d9700f/badge.svg?style=flat-square)](https://www.versioneye.com/user/projects/58cc3b2fdcaf9e0045d9700f)
[![Build Status](https://travis-ci.org/maoo/symphony-hubspot.svg)](https://travis-ci.org/maoo/symphony-hubspot)

# Hubspot Webhook Integration

A simple integration to connect Hubspot workflows (webhooks) with Symphony chat.
Right now, it is possible to easily connect a Hubspot form submission with a chat (either group or 1:1) notification.

This project is forked from the [Symphony Universal Integration](https://github.com/symphonyoss/App-Integrations-Universal), where you can read more about the integration framework.

## Run locally

1. Define your certificate paths and passwords
```
cp local-run/env.sh.sample env.sh
open env.sh
```

Make sure that
- Paths and passwords are correct
- You can reach all Symphony Pod endpoints
- Service accounts exists and cert CNs match with account's usernames
- `./env.sh`, `./application.yaml` and `./certs/` are ignored by Git and don't end up in any code repository

2. Run the integrations
```
./run.sh
```

This command will create an `application.yaml` file in the project root folder, using `local-run/application.yaml.template` as template.

## Expose local endpoint to a public host

In order to be able to create the app in the Foundation pod, you must provide a public `App Url`; you can use [ngrok](https://ngrok.com/) (or similar) to tunnel your local connection and expose it via a public DNS:
```
ngrok http 8080
```

Your local port 8080 is now accessible via `<dynamic_id>.ngrok.io`

If you have a paid subscription, you can also use
```
ngrok http -subdomain=my.static.subdomain 8080
```

Note. The team is working on a integration-provisioning module that will automate this process; until further notice, please contact Symphony Support to get your Symphony integration deployed on your pod.
