echo '*************************************************************************************************'
echo 'DESTROY K8s OBJECTS'
echo '*************************************************************************************************'
cd 'gcp-pulumi'
#npm install
pulumi destroy --yes

echo '*************************************************************************************************'
echo 'DESTROY IMAGE'
echo '*************************************************************************************************'
#Login into GKE
docker login -u _json_key -p "${GOOGLE_CREDENTIALS}" https://gcr.io
#Remove local image
docker rmi gcr.io/${GCP_PROJECT_ID}/${DOCKER_BUILD_NAME}:latest 

#Remove GKE Image
#gcloud container images delete gcr.io/${GCP_PROJECT_ID}/${DOCKER_BUILD_NAME}:latest --quiet

#Remove Repository
#Take care on it. If you delete Repository, you can't use the same name for 7 days
#gcloud source repos delete py-server $DOCKER_BUILD_NAME --quiet