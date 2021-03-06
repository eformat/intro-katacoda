ssh -i ~/.ssh/id_rsa root@host01 "/root/.set-hostname && rm -rf /openshift.local* && /var/lib/openshift/openshift start --write-config /openshift.local.config/ && sed -i 's/masterPublicURL.*/masterPublicURL: https:\/\/[[HOST_SUBDOMAIN]]-8443-[[KATACODA_HOST]].environments.katacoda.com:443/g' /openshift.local.config/master/master-config.yaml && sed -i s/router\.default\.svc\.cluster\.local/[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/g /openshift.local.config/master/master-config.yaml && sed -i 's/assetPublicURL.*/assetPublicURL: https:\/\/[[HOST_SUBDOMAIN]]-8443-[[KATACODA_HOST]].environments.katacoda.com:443\/console\//g' /openshift.local.config/master/master-config.yaml && sed -i 's/publicURL.*/publicURL: https:\/\/[[HOST_SUBDOMAIN]]-8443-[[KATACODA_HOST]].environments.katacoda.com:443\/console\//g' /openshift.local.config/master/master-config.yaml && systemctl restart origin"
echo '{' >> route.json
echo '  "metadata": {' >> route.json
echo '    "name": "frontend"' >> route.json
echo '  },' >> route.json
echo '  "apiVersion": "v1",' >> route.json
echo '  "kind": "Route",' >> route.json
echo '  "spec": {' >> route.json
echo '    "to": {' >> route.json
echo '      "name": "frontend"' >> route.json
echo '    }' >> route.json
echo '  }' >> route.json
echo '}' >> route.json
scp route.json root@host01:~/route.json
ssh root@host01 "oc adm registry -n default --config=/openshift.local.config/master/admin.kubeconfig"
ssh root@host01 "docker pull ocelotuproar/alpine-node:5.7.1"
