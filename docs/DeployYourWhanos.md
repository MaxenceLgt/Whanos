# Deploy Your Own Whanos Infrastructure

## Prerequisites  
- A Microsoft Azure account with sufficient credits to create and maintain an Azure virtual machine online.


## Table of Contents  

- [Create an Azure Virtual Machine](#create-an-azure-virtual-machine)
- [Set Up Whanos Requirements](#set-up-whanos-requirements)  
  - [Ansible Deployment Prerequisites](#ansible-deployment-prerequisites)  
  - [Jenkins Variables Configuration](#jenkins-variables-configuration)  
- [Deploy Your Whanos Infrastructure](#deploy-your-whanos-infrastructure)
- [Authors](#authors)  

## Create an Azure Virtual Machine
To deploy the Whanos infrastructure online, you first need to create an Azure Virtual Machine, as the deployment process is designed to work specifically with Azure.

To do so, connect to your Azure account, go to the `Virtual Machine` section, and click on `Create` -> `Azure virtual machine`.  
You should see something like this:  
![Create Azure VM](./assets/CreateAzureVM.png)

On the first page, fill in the following fields:  
- `Resource group`: Create one if you don't already have one, or select the group you want it to belong to.  
- `Virtual machine name`: The name to assign to your virtual machine.  
- `Region`: Choose the Azure region that best suits you and your customers. Note that not all VM sizes are available in all regions.  
- `Image`: Select **Debian 12 "Bookworm" - x64 Gen2**.  
- `VM Architecture`: Select **x64**.  
- `Username`: The username you will use to connect via SSH to your virtual machine.  
- `SSH public key source`: Select **Use existing public key**.  
- `SSH public key`: Provide your SSH public key.  
- `Select inbound ports`: Tick **SSH (22)** and **HTTP (80)**.  

---

**Note**  
- All values not mentioned should remain as default.  

---

Once these values are filled, click on `Review + Create` and then `Create`. When your virtual machine is fully deployed, you should see something like this:  
![Azure Success](./assets/AzureSuccess.png)

---

**Notes**  
For Ansible deployment, you will need to store two pieces of information from your newly created virtual machine:  

- **Username**: The username you specified when creating the machine.  
- **Public IP**: The public IP address of the virtual machine. You can find it by clicking the `Go to resource` button or by accessing your virtual machine settings from the Azure home page.  

---  