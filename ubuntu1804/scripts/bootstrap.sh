echo "============== Update extension ..."
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
containerid=$(docker run -d -e "APPID=$APPID" -v $(pwd):/src microsoft/azure-cli /src/containerlogic1.sh)
docker wait $containerid
docker logs $containerid



