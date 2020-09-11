#!/bin/bash

# asume we are in race.

# straight kubectl apply

kubectl -n big apply -f https://gelgitlab.race.sas.com/GEL/visualization/ddc-container/-/raw/manifest_work/manifest/ddc_manifest.yaml

cat << EOF > /tmp/ddc-ingress.yaml
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ddc-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  rules:
    - host: big.$(hostname -f)
      http:
        paths:
          - backend:
              serviceName: ddc-service
              servicePort: 3000
            path: /ddc
EOF

kubectl apply -f /tmp/ddc-ingress.yaml -n big

printf "URL for DDC ingress: http://big.$(hostname -f)/ddc \n"