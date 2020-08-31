# set -e
# if [ -z "$AWS_REPO" ]; then
#     export AWS_REPO="940120858061.dkr.ecr.ap-southeast-2.amazonaws.com"
# fi
name="webpack-docker-template"
version="0.0.1"
image_id="$name:$version"
latest_id="$name:latest"
#sudo docker build -t "$AWS_REPO/$image_id" -t "$AWS_REPO/$latest_id"  -f ./Dockerfile ./
sudo docker build -t "$latest_id"  -f ./Dockerfile ./