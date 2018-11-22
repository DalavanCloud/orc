echo "============== Bootstrap script arguments ..."
APPID=$1
echo $APPID


echo "============== Installing docker engine ..."

#update your existing list of packages
sudo apt update

# prerequisite packages which let apt use packages over HTTPS
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# add the GPG key for the official Docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package database with Docker packages from new repo
sudo apt-get update

# Install Docker
sudo apt install -y docker-ce
	
echo "=========== Finished installing docker engine."

# Install JQ
sudo apt install -y jq

echo "============== pwd ..."
pwd

echo "============== Start first container ..."
# -it for interactive, this will ensure the vm extension in the orchestrator will wait for the script to complete (max runtime for an extension?)
# -e to pass in a variable. The $myvar will be available in the container 
# files are downloaded by the vm extension to /var/lib/waagent/custom-script/download/0, this is the pwd when the agent executes the script
# -v to map the current working directory to /src folder in the container (created in the pwd)
# /src/sontainerlogic1.sh to run the script from the /src container (mapped from the host, downloaded by the vm extension)
# the /src/containerlogic1.sh needs to start with #!/bin/bash
sudo docker run -it -e "APPID=$APPID" -v $(pwd):/src microsoft/azure-cli /src/containerlogic1.sh



