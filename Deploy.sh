#!/bin/bash
 
# Variables
echo "Deployment Branch:$BRANCH_NAME"
if  [ "$BRANCH_NAME" = "dev" ]; then
docker stop myreact-app || true
docker rm myreact-app || true
docker pull rana1993/dev_guvi:latest
docker run -d -p 80:80 --name myreact-app rana1993/dev_guvi:latest
elif  [ "$BRANCH_NAME" = "main" ]; then
docker stop myreact-app || true
docker rm myreact-app || true
docker pull rana1993/prod_guvi:latest
docker run -d -p 80:80 --name react-app rana1993/prod_guvi:latest
fi
echo "Deployment sucessfully completed."