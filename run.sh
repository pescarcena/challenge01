#Solicita que tipo de operacion se va realizar
EDITOR=vim
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'

echo '*************************************************************************************************'
echo 'LOAD ENVIROMENTS'
echo '*************************************************************************************************'
#Load Credentials from creatianls.json
export GOOGLE_CREDENTIALS=$(cat credentials.json)
export PULUMI_CONFIG_PASSPHRASE='123456'
export GCP_PROJECT_ID=$(echo $(cat credentials.json | grep '"project_id": "' | cut -f2- -d: | sed 's/[",]//g'))
export CLOUDSDK_CORE_PROJECT=$GCP_PROJECT_ID
#Load env from .env file
if [ -f .env ]; then
	export $(cat .env | sed 's/#.*//g' | xargs)
fi

pause() {
	read -p "Press [Enter] key to continue..." fackEnterKey
}

create() {

	#Build, create and push Docker PyhtonApp image to GKE Registry
	sh docker.sh

	#Create Cluster K8s, Ingress and Deploy PyhtonApp
	sh deployk8s.sh

	exit
}

destroy() {
	
	#Destroy proyect
	sh destroy.sh

	exit
}

# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1) CREATE"
	echo "2) DESTROY"
	echo "3) OUTPUT"
}

# read input from the keyboard and take a action
read_options() {
	local choice
	read -p "Enter choice [ 1 - 3] " choice
	case $choice in
	1) create ;;
	2) destroy ;;
	3) exit 0 ;;
	*) echo "${RED}Invalid Option...${STD}" && sleep 2 ;;
	esac
}

# Show option list
while true; do

	show_menus
	read_options

done
