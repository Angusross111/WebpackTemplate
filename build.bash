#!/bin/bash
set -e
args=("$@")

echo "Enter version:"
read version

name="webpack-docker-template"
latest_id="$name:latest"
image_id="$name:$version"
AWS_id="$AWS_REPO/$image_id"
AWS_latest="$AWS_REPO/$latest_id"

pushAWS(){
    image_id="$name:$1"
    
    sudo docker build -t $AWS_id -t $AWS_latest  -f ./Dockerfile ./
    aws_version="$(aws --version | cut -d' ' -f 1 | cut -d'/' -f 2)"
    aws_maj_version="$(echo $aws_version | cut -d'.' -f 1)"
    aws_min_version="$(echo $aws_version | cut -d'.' -f 2)"
    if (( $aws_maj_version >= 2 )) || (( $aws_min_version >= 18 )); then
        # Newer cli version
        aws ecr get-login-password --region ap-southeast-2 | sudo docker login --username AWS --password-stdin "$AWS_REPO"
    else
        # Older cli version
        aws ecr get-login | bash
    fi
    sudo docker push $AWS_id
    sudo docker push $latest_id
    echo "Pushed ${image_id} and ${latest_id} AWS ------>";
}
runLocal(){
    echo "Enter port:"
    read port
    echo docker run -d "-p${port}:80" --name ${name} $AWS_id
    docker run -d -p$port:80 --name ${name} $AWS_id
    echo "Running on $port"
}
buildLocal(){ 
    if docker container inspect "$name" &> /dev/null; then
        docker stop $name
        docker rm $name
    fi
    if docker image inspect "$AWS_id" &> /dev/null; then
        echo "$AWS_id already exists, do you want to run it? (y/n)"
        read run
        if [ "$run" == "y" ]; then
            runLocal
        fi
        return 1
    fi
    
    sudo docker build -t "$AWS_REPO/$image_id"  -f ./Dockerfile ./
    echo "Built: ${image_id}"
}

if [ ${args[0]}  == "push" ]
then
    echo "Pushing to AWS!"
    pushAWS
elif  [ ${args[0]}  == "local" ]
then
    if [ ${args[1]}  == "run" ]
    then
        echo "Building and running locally"
        buildLocal
        runLocal
    else
        echo "Building Locally"
        buildLocal
    fi
else
    echo "Args not recognised, options are:"
    echo "\"push\": Build and push to AWS"
    echo "\"local\": Build Locally"
    echo "\"local run\": Build and run Locally"
fi


