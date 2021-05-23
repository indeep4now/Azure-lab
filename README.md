# Azure-lab
This is Azure web sever environment, 3 web severs, elk monitoring, and the Yaml scripts for the ansible containers, this is my 1st walk through you have been warned.



So, welcome to my Elk stack azure lab repo. I'll walk you through how I set up this  Virtual cloud environment, with elk monitoring capabilities. Here is a quick diagram of the structure to see what I am going to walk you through.

Description of the topology 
[top.pdf](https://github.com/indeep4now/Azure-lab/files/6527452/top.pdf)




The main function of all this is the safeguarding and monitoring of a web application server, in my case DVWA or damn vulnerable web application. I'll start from front to back.

On the front end, a load balancer to distribute traffic to the three web servers, to mitigate the chances of DOS attack.

The three web servers running Linux Ubuntu IOS, are zoned into the same availability zone to provide redundancy.    

The local workstation IP address is configured to the network security group (firewall)  meaning the only way to log into the jumpbox is by SSH (secure shell)  through the firewall on port 22 is from the local workstation IP. For security, the local authentication is with a public private key pair. 

From the jumpbox, you can then SSH to the web application servers by there corresponding private IP addresses. 

Monitoring is done by an ELK stack, which stands for elasticsearch, logstash, and Kibana, that has been segregated from the virtual network (10.1.0.0/16) containing the web servers. This is to segment the opportunity for failure or compromise.

The ELK network (10.0.0.0/16) has its own network security group with its own firewall inbound rules allowing SSH from jumpbox.


ELK configuration 

Using an ansible container, elk was configured to the monitoring VM. This step was automated to make set-up and configuration easy over multiple machines at once. Using a ansible play book yaml  file which automates: 

 Installing the docker.io
Installing Python/ pip3 modules
Downloads the docker ELK container 
Allows and executes increase in virtual memory
Enable the ELK to start on boot 

The ELK config file is list below.



Filebeat and metric config

Below are the config files for the file beat and metric beat



But first, on your virtual network you should have already setup you'll need to docker to install docker-container to install ansible into, with the command; 

Sudo docker run -ti cyberxsecurity/ansible bash

Only use run to start new container, to pick up where you left off or to restart use

sudo docker container list -a
sudo docker start <DESIRED CONTAINER NAME>
sudo docker attach <DESIRED CONTAINER NAME>
  
  once there attached, run the filebeat.yml and the metricbeat.yml to  Inside the appropriate beats config files, update the kibana & elastic options with the  desired local IP's. In the Filebeat-config.yml, the lines to change are 1105 & 1804. In the Metricbeat-config.yml file the line to change is 61.
  navigate to the /etc/ansible/host directory nano the host files to edit the VM IP address and uncomment the websever to "turn on" the web servers to run.
   After that navigate to the ansible config file by following this path /etc/ansible/ansible.cfg , here you want to edit the remote user, to the username you selected for your VM's.
  Return to root, let make some public keys to enable you to securly sign in to your network, run
  
  ssh-keygen
  cat ~/.shh/id_rsa.pub   to see the public key, copy this key and return to azure, VM to reset passwords. Here you can update the ssh key pair.
  
   return to the root, filebeat.yml and metricbeat.yml and config-elk-docker.yml to install the "guts" of the system.
  Now from the /etc/ansible/ run the ansible-playbook dvwa.yml and that should be it, to troubleshoot: check to make sure your IP hasnt changed, double check host-connect-file to match what i did to your file. 
