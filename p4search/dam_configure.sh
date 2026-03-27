#!/usr/bin/env bash

sed -i "s|^\(com.perforce.p4search.core.p4port=\).*$|\1$HTH_HELIX_P4PORT|" /opt/perforce/helix-p4search/etc_in/default.config.properties &&
sed -i "s|^\(com.perforce.p4search.core.p4trust=\).*$|\1$HTH_HELIX_FINGERPRINT|" /opt/perforce/helix-p4search/etc_in/default.config.properties &&
sed -i "s|^\(com.perforce.p4search.core.service.p4user=\).*$|\1$HTH_HELIX_USER|" /opt/perforce/helix-p4search/etc_in/default.config.properties &&
sed -i "s|^\(com.perforce.p4search.core.service.p4ticket=\).*$|\1$HTH_HELIX_PASSWORD|" /opt/perforce/helix-p4search/etc_in/default.config.properties &&
sed -i "s|^\(com.perforce.p4search.core.index.p4user=\).*$|\1$HTH_HELIX_USER|" /opt/perforce/helix-p4search/etc_in/default.config.properties &&
sed -i "s|^\(com.perforce.p4search.core.index.p4ticket=\).*$|\1$HTH_HELIX_PASSWORD|" /opt/perforce/helix-p4search/etc_in/default.config.properties &&
sed -i "s|^\(com.perforce.p4search.index.name=\).*$|\1$HTH_P4SEARCH_ES_INDEX|" /opt/perforce/helix-p4search/etc_in/default.config.properties &&
sed -i "s|^\(com.perforce.p4search.elastic.pass=\).*$|\1$HTH_P4SEARCH_ES_PASSWORD|" /opt/perforce/helix-p4search/etc_in/default.config.properties &&
sed -i "s|^\(com.perforce.p4search.service.token=\).*$|\1$HTH_P4SEARCH_TOKEN|" /opt/perforce/helix-p4search/etc_in/service.properties &&
sed -i "s|^\(com.perforce.p4search.service.external-url=\).*$|\1${HTH_URL/#https:/http:}|" /opt/perforce/helix-p4search/etc_in/service.properties &&
if [ $? -ne 0 ]; then
  echo "Failed to replace attributes in the default.config.properties file"
  exit $?
fi

export P4PORT=$HTH_HELIX_P4PORT
export P4USER=$HTH_HELIX_USER
export P4PASSWD=$HTH_HELIX_PASSWORD

if [[ "$P4PORT" == ssl* ]]; then
  p4 trust -i $HTH_HELIX_FINGERPRINT
  if [ $? -ne 0 ]; then
    echo "Failed to run p4 trust"
    exit $?
  fi
fi

p4 key -m com.perforce.p4search.render.service LocalRenderService com.perforce.p4search.render.model GLB
if [ $? -ne 0 ]; then
  echo "Failed to set p4 keys"
  exit $?
fi

echo "Configured"
