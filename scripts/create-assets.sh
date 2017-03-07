#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${DIR}/variables.tmpl.sh

CLUSTER_CREATE_URL="http://${MATCHBOX_IP}/cluster/create"
assets_zip="assets.zip"

# template outputs PAYLOAD variable
PAYLOAD=$(source ${DIR}/metal_payload.tmpl.sh)
#printf "${PAYLOAD}" |  >${assets_zip} curl -v -X POST --data-binary @- ${CLUSTER_CREATE_URL}
printf "${PAYLOAD}"
echo "Provisioning requested"


curl "http://${MATCHBOX_IP}:8080/ignition?uuid=19974d56-4178-078f-6ab8-a7a52d6d6204&mac=00-00-00-00-00-00&os=installed" -o controller_ignition.json
curl "http://${MATCHBOX_IP}:8080/ignition?uuid=8a0dee8e-fd62-4148-828b-024e8cb3033b&mac=00-00-00-00-00-10&os=installed" -o worker_ignition.json