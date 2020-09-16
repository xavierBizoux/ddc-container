#!/bin/bash
# Apply ddc_manifest.yaml to create the needed Deployment and Service

kubectl -n big apply -f https://raw.githubusercontent.com/xavierBizoux/ddc-container/master/manifest/ddc_manifest.yaml

# Create a manifest to define the Ingress resource
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

# Apply the newly yaml file
kubectl apply -f /tmp/ddc-ingress.yaml -n big

# Print the URL of the web application
printf "URL for DDC ingress: http://big.$(hostname -f)/ddc \n"