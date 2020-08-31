set -e
if [ -z "$AWS_REPO" ]; then
    export AWS_REPO="940120858061.dkr.ecr.ap-southeast-2.amazonaws.com"
fi
name="swarmfarm-apples-gui"
version="0.0.4"
image_id="$name:$version"
latest_id="$name:latest"
sudo docker build -t "$AWS_REPO/$image_id" -t "$AWS_REPO/$latest_id"  -f ./Dockerfile ./

#docker run -it --rm -d -p 8080:80 --name web webserver

sudo docker run -it --rm -d -p 8080:80 --name "$name" -v ~/AppleDataCaptureGUI/client/dist:/usr/share/nginx "$AWS_REPO/$image_id" 