#!/bin/bash
cat <<EOF
{
  "clusterKind": "tectonic-metal",
  "dryRun": false,
  "cluster": {
    "matchboxCA": "${MATCHBOX_CA}",
    "matchboxClientCert": "${MATCHBOX_ClientCert}",
    "matchboxClientKey": "${MATCHBOX_ClientKey}",
    "matchboxRPC": "${MATCHBOX_RPC}",
    "matchboxHTTP": "${MATCHBOX_HTTP}",
    "channel": "UNKNOWN",
    "externalETCDClient": "",
    "version": "1235.6.0",
    "controllerDomain": "${CLUSTER_CONTROLLERDOMAIN}",
    "tectonicDomain": "${CLUSTER_WORKERDOMAIN}",
    "controllers": [
      {
        "mac": "00:00:00:00:00:00",
        "name": "${CLUSTER_CONTROLLERNAME}"
      }
    ],
    "workers": [
      {
        "mac": "00:00:00:00:00:10",
        "name": "${CLUSTER_WORKERNAME}"
      }
    ],
    "sshAuthorizedKeys": [
      "${CLUSTER_SSHKEY}"
    ],
    "tectonic": {
      "ingressKind": "HostPort",
      "identityAdminUser": "admin@example.com",
      "identityAdminPassword": "dGVjdG9uaWNUZXN0UGFzczExMDQyMDE2",
      "license": "${CLUSTER_LICENSE}",
      "dockercfg": "${CLUSTER_DOCKERCFG}",
      "updater": {
        "enabled": true,
        "server": "",
        "channel": "",
        "appID": ""
      }
    }
  }
}
EOF