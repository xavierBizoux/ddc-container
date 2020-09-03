#!/bin/bash

# asume we are in race.

# straight kubectl apply

kubectl -n big apply -f https://gelgitlab.race.sas.com/GEL/visualization/ddc-container/-/raw/manifest_work/manifest/ddc_manifest.yaml

kubectl -n big get pods | grep ddc
kubectl -n big describe pod ddc-server-8564754859-kpwjh
   kubectl -n big get pods | grep ddc
 kubectl -n big logs  ddc-server-8564754859-kpwjh


 docker run -it --rm node:10-alpine ls /bin