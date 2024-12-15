# Whanos

The goal of this project is to create a complete CI/CD pipeline to deploy an application from a linked Git repository.

## Table of Contents
- [Development Tools](#development-tools)
- [Repository Architecture](#repository-architecture)
- [Supported Languages](#supported-languages)
- [Authors](#authors)

## Development Tools

Several development tools have been used or are planned to be implemented for this project:  
- **Docker**: Creation of Docker images for supported languages (currently in use).  
- **Ansible**: Deployment of the Whanos infrastructure on an Azure virtual machine (currently in use).  
- **Jenkins**: Tool for automating tests by detecting events or actions within the interface (currently in use).  
- **Kubernetes**: Application clustering (in development).  

## Repository Architecture

The repository for the Whanos infrastructure follows a straightforward structure:  
- Each Docker image is stored in the `images` directory, which contains subdirectories for each supported language (e.g., `c` for C, etc.).  
  Each language has two types of images: standalone images that can be used independently and base images designed to be extended via an application's Dockerfile.  

- Additionally, directories for Ansible deployments are located within the `jenkins` folder. Each subdirectory corresponds to a specific task (e.g., `nginx` for installation and configuration of Nginx, etc.).

## Supported Languages

Currently, our Whanos infrastructure supports a few basic languages:  
- C  
- Befunge  
- JavaScript  
- Java  
- Python  

As the project is still under development, it aims to support additional languages in the future, such as C++, and more.

## Authors
**[Maxence Largeot](https://github.com/MaxenceLgt)**  
**[Arthur Doriel](https://github.com/MrMarmotte)**