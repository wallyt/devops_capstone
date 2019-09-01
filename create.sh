aws cloudformation create-stack \
--stack-name capstone-kube \
--template-body file://eksvpcconfig.yaml \
--region=us-west-2