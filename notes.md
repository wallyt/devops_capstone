# Notes 
## Jenkins X

Used AWS [blog post](https://aws.amazon.com/blogs/opensource/continuous-delivery-eks-jenkins-x/). 

### Create EKS cluster
jx create cluster eks --cluster-name=capstone-kube --skip-installation=true
jx create cluster eks --skip-installation

### Install Jenkins X into cluster
jx install --provider=eks --domain=groksit.com --default-environment-prefix=capstone-kube
jx install --provider=eks --no-tiller

### Create new Spring Boot application
jx create spring -d web -d actuator

### Navigate into project
cd <appname>

### Promote project from staging into production
jx promote --version 0.0.1 --env production




https://github.com/jenkins-x-quickstarts for app
https://github.com/jenkins-x-quickstarts/php-helloworld