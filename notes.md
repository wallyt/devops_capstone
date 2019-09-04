# Notes 
## Jenkins X

Used AWS [blog post](https://aws.amazon.com/blogs/opensource/continuous-delivery-eks-jenkins-x/). 

### Create cluster
jx create cluster eks --cluster-name=capstone-kube --skip-installation=true

### Install Jenkins X
jx install --provider=eks --domain=$IP.ip --default-environment-prefix=capstone-kube