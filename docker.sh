#Load Credentials
# export GOOGLE_CREDENTIALS=$(cat credentials.json)
# export GCP_PROJECT_ID=$( echo $(cat credentials.json|grep '"project_id": "' | cut -f2- -d: | sed 's/[",]//g'))

# if [ -f .env ]
# then
#   export $(cat .env | sed 's/#.*//g' | xargs)
# fi

#

echo '*************************************************************************************************'
echo 'DOCKER BUILD'
echo '*************************************************************************************************'
#Build from code
docker build -t ${DOCKER_BUILD_NAME}:latest .

echo '*************************************************************************************************'
echo 'DOCKER TAG'
echo '*************************************************************************************************'
docker tag ${DOCKER_BUILD_NAME}:latest gcr.io/${GCP_PROJECT_ID}/${DOCKER_BUILD_NAME}:latest

echo '*************************************************************************************************'
echo 'DOCKER LOGIN GKE'
echo '*************************************************************************************************'
#Login to GKE Registry
docker login -u _json_key -p "${GOOGLE_CREDENTIALS}" https://gcr.io

echo '*************************************************************************************************'
echo 'DOCKER PUSH GKE'
echo '*************************************************************************************************'
#Push local image to GKE Registry
docker push gcr.io/${GCP_PROJECT_ID}/${DOCKER_BUILD_NAME}:latest


