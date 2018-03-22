# We start from an ubuntu image
FROM ubuntu
#setup of the proxy variables
ENV http_proxy=http://web-proxy.europe.hp.com:8080
ENV https_proxy=http://web-proxy.europe.hp.com:8080

#Clean up caches
RUN apt-get clean
RUN apt-get update

# Install the required packages for NPM
RUN apt-get update -yq 
RUN apt-get upgrade -yq 
RUN apt-get install -yq apt-utils
RUN apt-get install -yq curl git nano 
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - 
RUN apt-get install -yq nodejs build-essential

#Install npm
RUN npm install -g npm
#Install newman
RUN npm install -g newman

# Final Cleanup
RUN apt-get -qy autoremove
