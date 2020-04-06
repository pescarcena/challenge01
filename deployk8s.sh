echo '*************************************************************************************************'
echo 'PULUMI PROJECT'
echo '*************************************************************************************************'
#go into pulumi proyect
cd 'gcp-pulumi'
npm install

echo '*************************************************************************************************'
echo 'PULUMI CONFIG'
echo '*************************************************************************************************'
#Set some pulumi config values
pulumi config set gcp:project ${GCP_PROJECT_ID}
pulumi config set gcp:region ${GKE_REGION}
pulumi config set gcp:zone ${GKE_ZONE}

echo '*************************************************************************************************'
echo 'PULUMI SELECT STACK'
echo '*************************************************************************************************'
pulumi stack init dev --non-interactive
# pulumi stack select dev --non-interactive
#pulumi stack --non-interactive

echo '*************************************************************************************************'
echo 'PULUMI UP'
echo '*************************************************************************************************'
#Do the hard work
pulumi up --non-interactive

echo '*************************************************************************************************'
echo 'PULUMI EXPORT KUBECONFIG'
echo '*************************************************************************************************'
#Export Kubeconfig
pulumi stack output kubeconfig >kubeconfig
export KUBECONFIG=$PWD/kubeconfig

#Export PythonApp IP
pulumi stack output pyhtonAppServicePublicIP > pythonAppIp

# kubectl version
# kubectl cluster-info
# kubectl get nodes
echo '*************************************************************************************************'
echo 'INGRESS URL'
echo '*************************************************************************************************'


echo '*************************************************************************************************'
echo 'PYTHONAPP URL PROJECT'
echo '*************************************************************************************************'
export PYTHONAPP_IP=$(pulumi stack output pyhtonAppServicePublicIP)
export PYTHONAPP_BASE_URL=$(echo 'http://'$PYTHONAPP_IP':'$PY_SERVER_PORT'')

echo "/greetings -> "$PYTHONAPP_BASE_URL"/greetings"
echo "/square -> "$PYTHONAPP_BASE_URL"/square "