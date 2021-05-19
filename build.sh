#!/usr/bin/env bash
name="test-nginx-container"
latest_id="${name}:latest"

echo ${latest_id}

webpack --config webpack.prod.js

docker build -t ${latest_id}  -f ./local-test.dockerfile ./
docker run -d -p443:443 -v "/etc/swarmfarm/certs/angus_swarmfarm_com.key:/etc/swarmfarm/certs/star_swarmfarm_com.key" \
 -v "/etc/swarmfarm/certs/angus_swarmfarm_com.pem:/etc/swarmfarm/certs/star_swarmfarm_com.pem" \
    -v "/home/angus/WebpackTemplate/dist:/usr/share/nginx/html/:ro" \
    --name ${name} ${latest_id}
