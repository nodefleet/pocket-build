export BRANCH_NAME="update_tendermint"
export IMAGE_NAME="update_tendermint"
export DOCKER_REPO="pocket-core-testnet"
export DOCKER_REPO_="pocket-testnet"

export COMMIT=""
export REPO="https://github.com/pokt-network/pocket-core.git"

echo "----- Wiping all cache and image data -----"
yes | sudo docker system prune
yes | sudo docker image prune -a
sudo docker rm nodefleet/$DOCKER_REPO:$IMAGE_NAME 
sudo docker rm nodefleet/$POCKER_REPO_:$IMAGE_NAME 
yes | sudo docker system prune
yes | sudo docker container prune
yes | sudo docker volume prune

echo "----- Buliding pocket image -----"
cd ./docker
sudo docker build --no-cache -t nodefleet/$DOCKER_REPO:$IMAGE_NAME --build-arg BRANCH_NAME=$BRANCH_NAME --build-arg REPO=$REPO --build-arg COMMIT=$COMMIT .
sudo docker push nodefleet/$DOCKER_REPO:$BRANCH_NAME
cd ../docker-base
sudo docker build  --no-cache -t nodefleet/$DOCKER_REPO_:$IMAGE_NAME --build-arg BRANCH_NAME=$BRANCH_NAME --build-arg REPO=$REPO --build-arg DOCKER_REPO=$DOCKER_REPO --build-arg COMMIT=$COMMIT .
sudo docker push nodefleet/$DOCKER_REPO_:$IMAGE_NAME

